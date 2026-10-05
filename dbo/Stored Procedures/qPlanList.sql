
CREATE PROCEDURE [dbo].[qPlanList]
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
        --
        -- Access передаёт 0 и пустые строки как значения "фильтр не задан".
        -- Внутри процедуры такие значения приводятся к NULL, чтобы далее
        -- единообразно использовать условия:
        --
        --     @Parameter IS NULL OR Field = @Parameter
        --
        -- Для дат Access может передавать 1900-01-01 как значение-заглушку
        -- пустого поля даты.
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
        --
        -- SYSTEM_USER возвращает имя текущего пользователя SQL Server.
        -- По нему определяем сотрудника и его отдел.
        --
        -- Эти значения используются для ограничения области видимости
        -- данных для Manager и обычного Employee.
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
        --
        -- Роли определяют максимальную область видимости данных.
        --
        -- Admin:
        --   может использовать переданные @IdEmp / @IdDept
        --   без принудительного ограничения.
        --
        -- Maneger:
        --   видит только свой отдел.
        --   Переданный @IdEmp игнорируется.
        --
        -- Остальные пользователи:
        --   видят только свои записи.
        --   Переданный @IdDept игнорируется.
        --
        -- Имя роли 'Maneger' является фактическим именем роли в БД
        -- и намеренно не исправляется здесь.
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
        --   оставляет переданные @IdEmp / @IdDept как есть.
        --
        -- Manager:
        --   принудительно ограничивается своим отделом.
        --
        -- Employee:
        --   принудительно ограничивается самим собой.
        --
        -- Таким образом, обычный пользователь не может расширить область
        -- видимости, передав другой @IdEmp или @IdDept.
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
        -- TLC определяется по отделу выбранного сотрудника либо
        -- непосредственно по выбранному отделу.
        --
        -- TLC = 0:
        --   авторская сторона — план фильтруется по автору/отделу автора.
        --
        -- TLC = 1:
        --   сторона исполнителя — дополнительно проверяется актуальное
        --   распределение плана на сотрудника или отдел.
        --
        -- Если одновременно задан @IdEmp и @IdDept, приоритет имеет @IdEmp.
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
        --
        -- В этом случае Admin получает планы независимо от автора и отдела.
        -- Остальные фильтры (@NumPlan, @IdDocIn, @IdType, даты) сохраняются.
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
            --
            -- Из истории tSMeasStatus выбирается только последняя запись.
            --
            -- DateStatus определяет актуальность статуса.
            -- IdSMeasStatus является дополнительным критерием,
            -- обеспечивающим однозначный выбор при одинаковой DateStatus.
            --
            -- CROSS APPLY одновременно исключает планы, у которых
            -- отсутствует история статусов.
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

                ----------------------------------------------------------------
                -- Если задана конкретная дата, используется только она.
                -- Иначе применяется диапазон DateBeg ... DateEnd.
                --
                -- Правая граница диапазона сделана исключительной:
                -- < DATEADD(day, 1, @DateEnd)
                -- Это корректно работает и для datetime, если тип поля
                -- в дальнейшем изменится с date на datetime.
                ----------------------------------------------------------------

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

                ----------------------------------------------------------------
                -- Фильтр по фактической дате исполнения.
                -- План должен охватывать указанную дату.
                ----------------------------------------------------------------

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
                -- Выполненные планы (IdOrdr = 6) показываются всегда.
                -- Закрытые (IdOrdr = 7) добавляются при @ViewComplete = 1.
                ----------------------------------------------------------------

                AND st1.IdOrdr <= (6 + @ViewComplete)

            ----------------------------------------------------------------------
            -- Набор параметров процедуры сильно влияет на оптимальный план
            -- выполнения. RECOMPILE заставляет SQL Server строить план
            -- с учётом фактических значений параметров каждого вызова,
            -- снижая риск неудачного cached plan.
            ----------------------------------------------------------------------

            OPTION (RECOMPILE);

            -- Результат этой ветки уже сформирован.
            RETURN;
        END;


        ----------------------------------------------------------------------
        -- АВТОРСКАЯ СТОРОНА
        --
        -- TLC = 0.
        --
        -- Здесь план выбирается по автору и/или отделу автора.
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
            --
            -- Выбирается последняя запись истории статусов.
            -- Второй критерий сортировки обеспечивает однозначность
            -- при одинаковой дате статуса.
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
                --
                -- Для авторской стороны переданные @IdEmp / @IdDept
                -- используются непосредственно как фильтры.
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

            ----------------------------------------------------------------------
            -- Оптимальный план может зависеть от конкретных значений
            -- многочисленных необязательных параметров.
            ----------------------------------------------------------------------

            OPTION (RECOMPILE);

            -- Результат авторской ветки сформирован.
            RETURN;
        END;


        ----------------------------------------------------------------------
        -- СТОРОНА ИСПОЛНИТЕЛЯ
        --
        -- TLC = 1.
        --
        -- Здесь недостаточно проверить автора плана:
        -- необходимо определить, кому план был распределён,
        -- и найти последний статус именно этого исполнителя/отдела.
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
            --
            -- Из истории статусов выбирается последняя запись
            -- со статусом "Распределен" (IdOStatus = 4).
            --
            -- Эта информация используется отдельно от текущего статуса:
            -- текущий статус показывает состояние плана,
            -- а последняя запись распределения — кому план назначен.
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
            --
            -- Из истории статусов выбирается последняя запись,
            -- в которой присутствует текущий сотрудник либо его отдел.
            --
            -- IdsEmp / IdsDept содержат идентификаторы списком.
            -- Пробелы вокруг идентификатора используются намеренно:
            --
            --     ' 12 15 27 '
            --
            -- поэтому поиск ' 12 ' не совпадёт, например,
            -- с идентификатором 112.
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
                --
                -- План должен быть распределён на текущего сотрудника
                -- либо, если сотрудник не задан, на его отдел.
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
                -- Закрыто = 7 показываем только при @ViewComplete = 1.
                ----------------------------------------------------------------

                AND st1.IdOrdr <= (6 + @ViewComplete)

            ----------------------------------------------------------------------
            -- Для исполнительской ветки особенно важны фактические значения
            -- @IdEmp / @IdDept и параметров фильтрации, поэтому оптимальный
            -- план также строится заново для каждого вызова.
            ----------------------------------------------------------------------

            OPTION (RECOMPILE);

            -- Результат исполнительской ветки сформирован.
            RETURN;
        END;


    END TRY

    BEGIN CATCH

        ----------------------------------------------------------------------
        -- ОБРАБОТКА ОШИБКИ
        --
        -- Ошибка SQL Server передаётся вызывающему приложению.
        -- Это позволяет Access получить сообщение SQL Server
        -- и обработать его своей системой ErrMsg.
        ----------------------------------------------------------------------

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

