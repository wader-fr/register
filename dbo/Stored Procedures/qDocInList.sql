
CREATE PROCEDURE [dbo].[qDocInList]
--DECLARE
    @IdTypeDoc int = NULL,
    @IdTypeWork int = NULL,
    @Dept varchar(50) = NULL,
    @IdService tinyint = NULL,

    @NoDatePlane bit = 0,
    @NoDateEnd bit = 0,

    @YearDoc varchar(4) = NULL,
    @NumIn bigint = NULL,
    @NumOut varchar(50) = NULL,

    @DateInBeg date = NULL,
    @DateInEnd date = NULL,

    @DateContBeg date = NULL,
    @DateContEnd date = NULL,

    @IdBudget int = NULL,
    @NoEx bit = 0,
    @Contragent varchar(500) = NULL

AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        ----------------------------------------------------------------------
        -- НОРМАЛИЗАЦИЯ ПАРАМЕТРОВ
        --
        -- Access может передавать 0 или пустую строку как значение
        -- "фильтр не задан".
        --
        -- Как и в qPlanList, внутри процедуры такие значения приводим
        -- к NULL и далее используем единый принцип:
        --
        --     @Parameter IS NULL OR ...
        ----------------------------------------------------------------------

        IF @IdTypeDoc = 0
            SET @IdTypeDoc = NULL;

        IF @IdTypeWork = 0
            SET @IdTypeWork = NULL;

        IF @IdBudget = 0
            SET @IdBudget = NULL;

        IF @YearDoc = ''
            SET @YearDoc = NULL;

        IF @NumOut = ''
            SET @NumOut = NULL;

        IF @Contragent = ''
            SET @Contragent = NULL;


        ----------------------------------------------------------------------
        -- ДАТЫ
        --
        -- Access может передавать 1900-01-01 как дату-заглушку
        -- для незаполненного поля.
        --
        -- В qPlanList такие значения приводятся к NULL.
        ----------------------------------------------------------------------

        IF @DateInBeg = '1900-01-01'
            SET @DateInBeg = NULL;

        IF @DateInEnd = '1900-01-01'
            SET @DateInEnd = NULL;

        IF @DateContBeg = '1900-01-01'
            SET @DateContBeg = NULL;

        IF @DateContEnd = '1900-01-01'
            SET @DateContEnd = NULL;


        ----------------------------------------------------------------------
        -- ПОДГОТОВКА ТЕКСТОВЫХ ФИЛЬТРОВ
        ----------------------------------------------------------------------

        IF @Dept IS NULL
            SET @Dept = '%';
        ELSE
            SET @Dept = '% ' + @Dept + ' %';


        -- Поиск исходящего номера через fnFindIndex.
        SET @NumOut = dbo.fnFindIndex(@NumOut, '%');


        -- Поиск контрагента через fnFindIndex.
        SET @Contragent = dbo.fnFindIndex(@Contragent, '%');


        ----------------------------------------------------------------------
        -- ПУТЬ К ПАПКЕ ПРЕДПИСАНИЙ
        --
        -- PathPred — корневая папка предписаний.
        ----------------------------------------------------------------------

        DECLARE @PathPred nvarchar(2000);

        SET @PathPred = dbo.fnGetOption('PathPred');


        ----------------------------------------------------------------------
        -- ОСНОВНАЯ ВЫБОРКА
        ----------------------------------------------------------------------

        SELECT

            di.IdDocIn,

            di.NumInA,
            di.DateIn,

            di.NumOut,
            di.DateOut,

            di.NoEx,
            di.YearDoc,

            di.NumCancel,
            di.DateCancel,

            di.NumCancelOut,
            di.DateCancelOut,

            di.ScanDocIn,
            di.IdOContract,
            ------------------------------------------------------------------
            -- Номер и дата инспекции
            ------------------------------------------------------------------

            di.NumInsp
                + N' от '
                + CONVERT(NVARCHAR, di.DateInsp, 4) AS Inspection,

            di.DatePlane,
            di.DateEnd,

            ------------------------------------------------------------------
            -- Форматированный входящий номер
            ------------------------------------------------------------------

            CONVERT(NVARCHAR, di.NumIn)
                + N'-'
                + di.Suffics AS NumInF,

            ------------------------------------------------------------------
            -- Наличие приложений
            --
            -- Количество нам не требуется.
            -- EXISTS возвращает TRUE уже при первой найденной записи.
            ------------------------------------------------------------------

            CASE
                WHEN EXISTS
                (
                    SELECT 1
                    FROM dbo.tAttach a
                    WHERE a.IdODocIn = di.IdDocIn
                )
                THEN 1
                ELSE 0
            END AS AttachC,

            ------------------------------------------------------------------
            -- Наличие поддокументов
            ------------------------------------------------------------------

            CASE
                WHEN EXISTS
                (
                    SELECT 1
                    FROM dbo.tSubDocIn sdi
                    WHERE sdi.IdODocIn = di.IdDocIn
                )
                THEN 1
                ELSE 0
            END AS SubDocC,

            ------------------------------------------------------------------
            -- Наличие сканов
            ------------------------------------------------------------------

            CASE
                WHEN EXISTS
                (
                    SELECT 1
                    FROM dbo.tScanDocIn sdi
                    WHERE sdi.IdODocIn = di.IdDocIn
                )
                THEN 1
                ELSE 0
            END AS ScanC,

            ------------------------------------------------------------------
            -- Подразделения
            ------------------------------------------------------------------

            a1.Depts AS Embed,
            a1.IdsDept,

            a2.Depts AS Accepted,

            ------------------------------------------------------------------
            -- Контрагент
            ------------------------------------------------------------------

            CASE
                WHEN c.sName IS NOT NULL
                    THEN ISNULL(pc.Property, '') + ' ' + c.sName
                ELSE c.fName
            END AS Contragent,

            ------------------------------------------------------------------
            -- Объект
            ------------------------------------------------------------------

            ISNULL
            (
                di.[Object],
                CASE
                    WHEN obj.sName IS NOT NULL
                        THEN ISNULL(p.Property, '') + ' ' + obj.sName
                    ELSE obj.fName
                END
            ) AS [Object],

            ------------------------------------------------------------------
            -- Вид документа
            ------------------------------------------------------------------

            dt.sDocType,

            ------------------------------------------------------------------
            -- Вид работы
            ------------------------------------------------------------------

            wt.WorkType,

            ------------------------------------------------------------------
            -- Договор
            ------------------------------------------------------------------

            ct.NumContract
                + ' от '
                + CONVERT(varchar(10), ct.DateContract, 104) AS NumContract,

            ------------------------------------------------------------------
            -- Полный путь к скану предписания
            --
            -- PathPred
            --     \Год
            --     \Номер-Suffics
            --     \Файл
            ------------------------------------------------------------------

            @PathPred
                + '\'
                + di.YearDoc
                + '\'
                + CONVERT(varchar(10), di.NumIn)
                + '-'
                + di.Suffics
                + '\'
                + di.ScanDocIn AS ScanPred


        FROM dbo.tblDocIn di


        ----------------------------------------------------------------------
        -- НАЗНАЧЕНИЯ
        --
        -- ftAppointment здесь не нужна.
        --
        -- Она фактически выполняла:
        --
        --     SELECT *
        --     FROM tAppointment
        --     WHERE IdOTypeApp = ...
        --
        -- Поэтому условие сразу перенесено в JOIN.
        ----------------------------------------------------------------------

LEFT JOIN dbo.tAppointment a1 --WITH (INDEX(IX_tAppointment_IdOTypeApp_IdODoc))
    ON a1.IdODoc = di.IdDocIn
    AND a1.IdOTypeApp = 1

LEFT JOIN dbo.tAppointment a2 --WITH (INDEX(IX_tAppointment_IdOTypeApp_IdODoc))
    ON a2.IdODoc = di.IdDocIn
    AND a2.IdOTypeApp = 2
        ----------------------------------------------------------------------
        -- КОНТРАГЕНТ
        ----------------------------------------------------------------------

        LEFT JOIN dbo.tblContragent c
            ON c.IdContragent = di.IdOContragent

           
        ----------------------------------------------------------------------
        -- ОБЪЕКТ
        ----------------------------------------------------------------------

        LEFT JOIN dbo.tblContragent obj
            ON obj.IdContragent = di.IdOObject

        LEFT JOIN dbo.tblProp p
            ON p.IdProperty = obj.IdOProperty

        LEFT JOIN dbo.tblProp pc
            ON pc.IdProperty = c.IdOProperty


        ----------------------------------------------------------------------
        -- ВИД ДОКУМЕНТА
        ----------------------------------------------------------------------

        LEFT JOIN dbo.tblDocType dt
            ON dt.IdDocType = di.IdOTypeDoc


        ----------------------------------------------------------------------
        -- ВИД РАБОТЫ
        ----------------------------------------------------------------------

        LEFT JOIN dbo.tblWorkType wt
            ON wt.IdWorkType = di.IdOTypeWork


        ----------------------------------------------------------------------
        -- ДОГОВОР
        ----------------------------------------------------------------------

        LEFT JOIN dbo.tContract ct
            ON ct.IdContract = di.IdOContract


        WHERE

            ------------------------------------------------------------------
            -- ГОД УЧЁТА
            ------------------------------------------------------------------

            (
                @YearDoc IS NULL
                OR di.YearDoc = @YearDoc
            )


            ------------------------------------------------------------------
            -- ЗАЯВИТЕЛЬ / КОНТРАГЕНТ
            ------------------------------------------------------------------

            AND
            (
                ISNULL(c.fName, '') LIKE @Contragent
                OR ISNULL(c.sName, '') LIKE @Contragent
            )


            ------------------------------------------------------------------
            -- ВХОДЯЩИЙ НОМЕР
            ------------------------------------------------------------------

            AND
            (
                @NumIn IS NULL
                OR di.NumIn = @NumIn
            )


            ------------------------------------------------------------------
            -- ИСХОДЯЩИЙ НОМЕР
            ------------------------------------------------------------------

            AND
            (
                @NumOut IS NULL
                OR ISNULL(di.NumOut, '') LIKE @NumOut
            )


            ------------------------------------------------------------------
            -- ВХОДЯЩАЯ ДАТА
            --
            -- Та же модель, что в qPlanList.
            --
            -- Начальная дата включается:
            --
            --     >= @DateInBeg
            --
            -- Конечная дата является включительной для пользователя,
            -- поэтому технически используется следующая дата:
            --
            --     < DATEADD(day, 1, @DateInEnd)
            --
            -- Это особенно важно, если DateIn имеет тип datetime.
            ------------------------------------------------------------------

            AND
            (
                @DateInBeg IS NULL
                OR di.DateIn >= @DateInBeg
            )

            AND
            (
                @DateInEnd IS NULL
                OR di.DateIn < DATEADD(day, 1, @DateInEnd)
            )


            ------------------------------------------------------------------
            -- КОНТРОЛЬНЫЙ СРОК
            --
            -- Аналогичная схема диапазона.
            ------------------------------------------------------------------

            AND
            (
                @DateContBeg IS NULL
                OR di.DatePlane >= @DateContBeg
            )

            AND
            (
                @DateContEnd IS NULL
                OR di.DatePlane < DATEADD(day, 1, @DateContEnd)
            )


            ------------------------------------------------------------------
            -- БЮДЖЕТ
            ------------------------------------------------------------------

            AND
            (
                @IdBudget IS NULL
                OR ISNULL(wt.IdOBudget, 0) = @IdBudget
            )


            ------------------------------------------------------------------
            -- БЕЗ КОНТРОЛЬНОГО СРОКА
            --
            -- 0 = фильтр не применяется.
            -- 1 = только документы без контрольного срока.
            ------------------------------------------------------------------

            AND
            (
                @NoDatePlane = 0
                OR di.DatePlane IS NULL
            )


            ------------------------------------------------------------------
            -- НЕЗАВЕРШЁННЫЕ
            --
            -- 0 = фильтр не применяется.
            -- 1 = только документы без даты окончания.
            ------------------------------------------------------------------

            AND
            (
                @NoDateEnd = 0
                OR di.DateEnd IS NULL
            )


            ------------------------------------------------------------------
            -- ВИД ДОКУМЕНТА
            ------------------------------------------------------------------

            AND
            (
                @IdTypeDoc IS NULL
                OR di.IdOTypeDoc = @IdTypeDoc
            )


            ------------------------------------------------------------------
            -- ВИД РАБОТЫ
            ------------------------------------------------------------------

            AND
            (
                @IdTypeWork IS NULL
                OR di.IdOTypeWork = @IdTypeWork
            )


            ------------------------------------------------------------------
            -- ПОДРАЗДЕЛЕНИЕ
            --
            -- IdsDept хранится списком идентификаторов.
            -- Существующая логика поиска сохраняется.
            ------------------------------------------------------------------

            AND
                ' ' + ISNULL(a1.IdsDept, '') + ' ' LIKE @Dept


            ------------------------------------------------------------------
            -- ИСКЛЮЧЕНИЕ
            ------------------------------------------------------------------

            AND
                di.NoEx <= @NoEx


        ----------------------------------------------------------------------
        -- СОРТИРОВКА
        ----------------------------------------------------------------------

        ORDER BY
            di.NumIn,
            di.YearDoc


        ----------------------------------------------------------------------
        -- RECOMPILE
        --
        -- OPTION является частью SELECT.
        -- Поэтому перед ним НЕ ставим точку с запятой.
        --
        -- SQL Server получает возможность построить план с учётом
        -- фактических значений параметров конкретного вызова.
        ----------------------------------------------------------------------

        OPTION (RECOMPILE);


    END TRY


    BEGIN CATCH

        ----------------------------------------------------------------------
        -- ОБРАБОТКА ОШИБКИ
        --
        -- Передаём ошибку SQL Server обратно в Access.
        ----------------------------------------------------------------------

        DECLARE @ErrorMessage nvarchar(4000);
        DECLARE @ErrorSeverity int;
        DECLARE @ErrorState int;

        SELECT
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR
        (
            @ErrorMessage,
            @ErrorSeverity,
            @ErrorState
        );

    END CATCH

END;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList] TO [Admin]
    AS [dbo];

