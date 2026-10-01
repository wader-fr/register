
CREATE PROCEDURE [dbo].[qPlanList]
--DECLARE
    @NumPlan nvarchar(5) = NULL,
    @IdDocIn bigint = NULL,
    @IdEmp int = NULL,
    @IdDept int = NULL,
    @Date date = NULL,
    @DateBeg date = NULL,
    @DateEnd date = NULL,
    @IdType int = NULL,
    @ViewComplete bit = 0,
    @DateActual date = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        ----------------------------------------------------------------------
        -- НОРМАЛИЗАЦИЯ ПАРАМЕТРОВ
        ----------------------------------------------------------------------

        IF @IdEmp = 0
            SET @IdEmp = NULL;

        IF @IdDept = 0
            SET @IdDept = NULL;

        IF @IdDocIn = 0
            SET @IdDocIn = NULL;

        IF @IdType = 0
            SET @IdType = NULL;

        IF @NumPlan = ''
            SET @NumPlan = NULL;

        IF @Date = '1900-01-01' OR @Date = '0:00:00'
            SET @Date = NULL;

        IF @DateBeg = '1900-01-01' OR @DateBeg = '0:00:00'
            SET @DateBeg = NULL;

        IF @DateEnd = '1900-01-01' OR @DateEnd = '0:00:00'
            SET @DateEnd = NULL;

        IF @DateActual = '1900-01-01' OR @DateActual = '0:00:00'
            SET @DateActual = NULL;


        ----------------------------------------------------------------------
        -- ТЕКУЩИЙ СОТРУДНИК
        ----------------------------------------------------------------------

        DECLARE @CurrentEmp int;
        DECLARE @CurrentDept int;

        SELECT
            @CurrentEmp = e.IdEmployee,
            @CurrentDept = e.IdODept
        FROM dbo.tblEmployee e
        WHERE e.lgn = SYSTEM_USER;


        ----------------------------------------------------------------------
        -- ПРАВА
        ----------------------------------------------------------------------

        DECLARE @IsAdmin bit = 0;
        DECLARE @IsManager bit = 0;

        IF IS_ROLEMEMBER('Admin') = 1
            SET @IsAdmin = 1;

        IF IS_ROLEMEMBER('Maneger') = 1
            SET @IsManager = 1;


        ----------------------------------------------------------------------
        -- ПРИОРИТЕТ ПРАВ НАД ПЕРЕДАННЫМИ ФИЛЬТРАМИ
        --
        -- Admin:
        --   оставляет переданные @IdEmp / @IdDept как есть
        --
        -- Manager:
        --   только свой отдел
        --
        -- Employee:
        --   только сам сотрудник
        ----------------------------------------------------------------------

        IF @IsAdmin = 0
        BEGIN

            IF @IsManager = 1
            BEGIN
                SET @IdDept = @CurrentDept;
                SET @IdEmp = NULL;
            END
            ELSE
            BEGIN
                SET @IdEmp = @CurrentEmp;
                SET @IdDept = NULL;
            END

        END;


        ----------------------------------------------------------------------
        -- ОПРЕДЕЛЯЕМ TLC
        --
        -- Если выбран сотрудник, его отдел имеет приоритет.
        -- Если сотрудник не выбран, смотрим выбранный отдел.
        ----------------------------------------------------------------------

        DECLARE @TLC bit = NULL;

        IF @IdEmp IS NOT NULL
        BEGIN

            SELECT
                @TLC = ISNULL(d.TLC, 0)
            FROM dbo.tblEmployee e
            INNER JOIN dbo.tblDept d
                ON d.IdDept = e.IdODept
            WHERE e.IdEmployee = @IdEmp;

        END
        ELSE IF @IdDept IS NOT NULL
        BEGIN

            SELECT
                @TLC = ISNULL(d.TLC, 0)
            FROM dbo.tblDept d
            WHERE d.IdDept = @IdDept;

        END;


        ----------------------------------------------------------------------
        -- ADMIN БЕЗ ФИЛЬТРА СОТРУДНИКА И ОТДЕЛА
        ----------------------------------------------------------------------

        IF @IsAdmin = 1
           AND @IdEmp IS NULL
           AND @IdDept IS NULL
        BEGIN

            SELECT
                smp.*,
                mt.sMeasType AS SMeasType,
                st1.SMeasStatus,
                st1.IdOrdr,
                st1.IdSMeasStatuses,
                ls.DateStatus,
                ls.Notes,
                e.FullName,
                d.sNameDept,
                e.IdODept
            FROM dbo.tSMeasPlan smp

            ------------------------------------------------------------------
            -- Тип мероприятия
            ------------------------------------------------------------------

            LEFT JOIN dbo.tSMeasType mt
                ON mt.IdSMeasType = smp.IdOSMeasType

            ------------------------------------------------------------------
            -- Последний статус плана
            ------------------------------------------------------------------

            CROSS APPLY
            (
                SELECT TOP 1
                    sm.IdOStatus,
                    sm.DateStatus,
                    sm.Notes
                FROM dbo.tSMeasStatus sm
                WHERE sm.IdOSMeasPlan = smp.IdSMeas
                ORDER BY
                    sm.DateStatus DESC,
                    sm.IdSMeasStatus DESC
            ) ls

            ------------------------------------------------------------------
            -- Автор плана
            ------------------------------------------------------------------

            INNER JOIN dbo.tblEmployee e
                ON e.IdEmployee = smp.IdOEmpCreate

            INNER JOIN dbo.tblDept d
                ON d.IdDept = e.IdODept

            INNER JOIN dbo.tStatuses st1
                ON st1.IdSMeasStatuses = ls.IdOStatus

            WHERE
                (@NumPlan IS NULL OR smp.NumSMeas = @NumPlan)

                AND (@IdDocIn IS NULL OR smp.IdODocIn = @IdDocIn)

                AND (@IdType IS NULL OR smp.IdOSMeasType = @IdType)

                AND
                (
                    (@Date IS NOT NULL
                     AND smp.DateSMeas = @Date)

                    OR

                    (@Date IS NULL
                     AND (@DateBeg IS NULL
                          OR smp.DateSMeas >= @DateBeg)
                     AND (@DateEnd IS NULL
                          OR smp.DateSMeas < DATEADD(day, 1, @DateEnd)))
                )

                AND
                (
                    @DateActual IS NULL
                    OR
                    (
                        smp.DateExecBeg <= @DateActual
                        AND smp.DateExecEnd >= @DateActual
                    )
                )

                AND st1.IdOrdr <= (6 + @ViewComplete)

            OPTION (RECOMPILE);

            RETURN;
        END;


        ----------------------------------------------------------------------
        -- АВТОРСКАЯ СТОРОНА
        --
        -- TLC = 0
        ----------------------------------------------------------------------

        IF @TLC = 0
        BEGIN

            SELECT
                smp.*,
                mt.sMeasType AS SMeasType,
                st1.SMeasStatus,
                st1.IdOrdr,
                st1.IdSMeasStatuses,
                ls.DateStatus,
                ls.Notes,
                e.FullName,
                d.sNameDept,
                e.IdODept
            FROM dbo.tSMeasPlan smp

            ------------------------------------------------------------------
            -- Тип мероприятия
            ------------------------------------------------------------------

            LEFT JOIN dbo.tSMeasType mt
                ON mt.IdSMeasType = smp.IdOSMeasType

            ------------------------------------------------------------------
            -- Последний статус плана
            ------------------------------------------------------------------

            CROSS APPLY
            (
                SELECT TOP 1
                    sm.IdOStatus,
                    sm.DateStatus,
                    sm.Notes
                FROM dbo.tSMeasStatus sm
                WHERE sm.IdOSMeasPlan = smp.IdSMeas
                ORDER BY
                    sm.DateStatus DESC,
                    sm.IdSMeasStatus DESC
            ) ls

            ------------------------------------------------------------------
            -- Автор плана
            ------------------------------------------------------------------

            INNER JOIN dbo.tblEmployee e
                ON e.IdEmployee = smp.IdOEmpCreate

            INNER JOIN dbo.tblDept d
                ON d.IdDept = e.IdODept

            INNER JOIN dbo.tStatuses st1
                ON st1.IdSMeasStatuses = ls.IdOStatus

            WHERE

                ----------------------------------------------------------------
                -- Общие фильтры
                ----------------------------------------------------------------

                (@NumPlan IS NULL OR smp.NumSMeas = @NumPlan)

                AND (@IdDocIn IS NULL OR smp.IdODocIn = @IdDocIn)

                AND (@IdType IS NULL OR smp.IdOSMeasType = @IdType)

                AND
                (
                    (@Date IS NOT NULL
                     AND smp.DateSMeas = @Date)

                    OR

                    (@Date IS NULL
                     AND (@DateBeg IS NULL
                          OR smp.DateSMeas >= @DateBeg)
                     AND (@DateEnd IS NULL
                          OR smp.DateSMeas < DATEADD(day, 1, @DateEnd)))
                )

                AND
                (
                    @DateActual IS NULL
                    OR
                    (
                        smp.DateExecBeg <= @DateActual
                        AND smp.DateExecEnd >= @DateActual
                    )
                )

                ----------------------------------------------------------------
                -- Автор
                ----------------------------------------------------------------

                AND
                (
                    @IdEmp IS NULL
                    OR smp.IdOEmpCreate = @IdEmp
                )

                AND
                (
                    @IdDept IS NULL
                    OR e.IdODept = @IdDept
                )

                ----------------------------------------------------------------
                -- Видимость по статусу
                ----------------------------------------------------------------

                AND st1.IdOrdr <= (6 + @ViewComplete)

            OPTION (RECOMPILE);

            RETURN;
        END;


        ----------------------------------------------------------------------
        -- СТОРОНА ИСПОЛНИТЕЛЯ
        --
        -- TLC = 1
        ----------------------------------------------------------------------

        IF @TLC = 1
        BEGIN

            SELECT
                smp.*,
                mt.sMeasType AS SMeasType,
                st1.SMeasStatus,
                st1.IdOrdr,
                st1.IdSMeasStatuses,
                ls.DateStatus,
                ls.Notes,
                e.FullName,
                d.sNameDept,
                e.IdODept
            FROM dbo.tSMeasPlan smp

            ------------------------------------------------------------------
            -- Тип мероприятия
            ------------------------------------------------------------------

            LEFT JOIN dbo.tSMeasType mt
                ON mt.IdSMeasType = smp.IdOSMeasType

            ------------------------------------------------------------------
            -- Последнее распределение
            ------------------------------------------------------------------

            CROSS APPLY
            (
                SELECT TOP 1
                    sm4.IdsEmp,
                    sm4.IdsDept
                FROM dbo.tSMeasStatus sm4
                WHERE sm4.IdOSMeasPlan = smp.IdSMeas
                  AND sm4.IdOStatus = 4
                ORDER BY
                    sm4.DateStatus DESC,
                    sm4.IdSMeasStatus DESC
            ) smsDistrib

            ------------------------------------------------------------------
            -- Последний статус именно этого исполнителя
            ------------------------------------------------------------------

            CROSS APPLY
            (
                SELECT TOP 1
                    sm.IdOStatus,
                    sm.DateStatus,
                    sm.Notes
                FROM dbo.tSMeasStatus sm
                WHERE sm.IdOSMeasPlan = smp.IdSMeas
                  AND
                  (
                      (
                          @IdEmp IS NOT NULL
                          AND CHARINDEX(
                              ' ' + CAST(@IdEmp AS nvarchar(20)) + ' ',
                              ISNULL(sm.IdsEmp, '')
                          ) > 0
                      )

                      OR

                      (
                          @IdEmp IS NULL
                          AND @IdDept IS NOT NULL
                          AND CHARINDEX(
                              ' ' + CAST(@IdDept AS nvarchar(20)) + ' ',
                              ISNULL(sm.IdsDept, '')
                          ) > 0
                      )
                  )
                ORDER BY
                    sm.DateStatus DESC,
                    sm.IdSMeasStatus DESC
            ) ls

            ------------------------------------------------------------------
            -- Автор плана
            ------------------------------------------------------------------

            INNER JOIN dbo.tblEmployee e
                ON e.IdEmployee = smp.IdOEmpCreate

            INNER JOIN dbo.tblDept d
                ON d.IdDept = e.IdODept

            INNER JOIN dbo.tStatuses st1
                ON st1.IdSMeasStatuses = ls.IdOStatus

            WHERE

                ----------------------------------------------------------------
                -- Общие фильтры
                ----------------------------------------------------------------

                (@NumPlan IS NULL OR smp.NumSMeas = @NumPlan)

                AND (@IdDocIn IS NULL OR smp.IdODocIn = @IdDocIn)

                AND (@IdType IS NULL OR smp.IdOSMeasType = @IdType)

                AND
                (
                    (@Date IS NOT NULL
                     AND smp.DateSMeas = @Date)

                    OR

                    (@Date IS NULL
                     AND (@DateBeg IS NULL
                          OR smp.DateSMeas >= @DateBeg)
                     AND (@DateEnd IS NULL
                          OR smp.DateSMeas < DATEADD(day, 1, @DateEnd)))
                )

                AND
                (
                    @DateActual IS NULL
                    OR
                    (
                        smp.DateExecBeg <= @DateActual
                        AND smp.DateExecEnd >= @DateActual
                    )
                )

                ----------------------------------------------------------------
                -- Проверяем актуальное распределение
                ----------------------------------------------------------------

                AND
                (
                    (
                        @IdEmp IS NOT NULL
                        AND CHARINDEX(
                            ' ' + CAST(@IdEmp AS nvarchar(20)) + ' ',
                            ISNULL(smsDistrib.IdsEmp, '')
                        ) > 0
                    )

                    OR

                    (
                        @IdEmp IS NULL
                        AND @IdDept IS NOT NULL
                        AND CHARINDEX(
                            ' ' + CAST(@IdDept AS nvarchar(20)) + ' ',
                            ISNULL(smsDistrib.IdsDept, '')
                        ) > 0
                    )
                )

                ----------------------------------------------------------------
                -- Выполнено = 6 ещё показываем.
                -- Закрыто = 7 только при @ViewComplete = 1.
                ----------------------------------------------------------------

                AND st1.IdOrdr <= (6 + @ViewComplete)

            OPTION (RECOMPILE);

            RETURN;
        END;

    END TRY

    BEGIN CATCH

        DECLARE @ErrorMessage nvarchar(4000);
        DECLARE @ErrorSeverity int;
        DECLARE @ErrorState int;

        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(
            @ErrorMessage,
            @ErrorSeverity,
            @ErrorState
        );

    END CATCH
END;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlanList] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlanList] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlanList] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlanList] TO [Admin]
    AS [dbo];

