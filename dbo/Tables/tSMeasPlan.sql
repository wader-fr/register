CREATE TABLE [dbo].[tSMeasPlan] (
    [IdSMeas]      BIGINT         IDENTITY (1, 1) NOT NULL,
    [NumSMeas]     INT            NULL,
    [DateSMeas]    DATETIME       NULL,
    [IdODocIn]     BIGINT         NULL,
    [IdOSMeasType] INT            NULL,
    [DateExecBeg]  DATETIME       NULL,
    [DateExecEnd]  DATETIME       NULL,
    [FNum]         AS             ((CONVERT([nvarchar](5),[NumSMeas],0)+'.')+right(CONVERT([nvarchar](4),datepart(year,[DateSMeas]),0),(2))) PERSISTED,
    [IdOEmpCreate] INT            CONSTRAINT [DF_tSMeasPlan_IdOEmpCreate] DEFAULT ([dbo].[fnGetCurrentEmployee]()) NOT NULL,
    [DateCreate]   DATETIME       CONSTRAINT [DF_tSMeasPlan_DateCreate] DEFAULT (getdate()) NOT NULL,
    [CreateHost]   NVARCHAR (128) CONSTRAINT [DF_tSMeasPlan_CreateHost] DEFAULT (host_name()) NOT NULL,
    CONSTRAINT [PK_tSMeasPlan] PRIMARY KEY CLUSTERED ([IdSMeas] ASC),
    CONSTRAINT [FK_tSMeasPlan_tblDocIn1] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn]),
    CONSTRAINT [FK_tSMeasPlan_tSMeasType] FOREIGN KEY ([IdOSMeasType]) REFERENCES [dbo].[tSMeasType] ([IdSMeasType])
);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasPlan_Filters]
    ON [dbo].[tSMeasPlan]([DateSMeas] ASC, [IdOSMeasType] ASC)
    INCLUDE([NumSMeas], [IdODocIn], [DateExecBeg], [DateExecEnd]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasPlan_Date]
    ON [dbo].[tSMeasPlan]([DateSMeas] ASC)
    INCLUDE([NumSMeas], [IdODocIn], [IdOSMeasType]);


GO
CREATE TRIGGER dbo.tr_tSMeasPlan_Process
ON dbo.tSMeasPlan
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;


    DECLARE @IdEmp int;

    -- Определяем сотрудника
    SELECT @IdEmp = e.IdEmployee
    FROM dbo.tblEmployee e
    WHERE e.lgn = SYSTEM_USER;


    ----------------------------------------------------------------
    -- INSERT: создание нового плана
    ----------------------------------------------------------------
    IF NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN

        -- Дата плана при создании должна быть не ранее входящего документа
        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            INNER JOIN dbo.tblDocIn d
                ON d.IdDocIn = i.IdODocIn
            WHERE i.DateSMeas < d.DateIn
        )
        BEGIN
            RAISERROR
            (
                N'Дата плана не может быть ранее даты входящего документа.',
                16,
                1
            );

            ROLLBACK TRANSACTION;
            RETURN;
        END;


        -- Создаём первый статус
        INSERT INTO dbo.tSMeasStatus
        (
            IdOStatus,
            DateStatus,
            IdOSMeasPlan,
            IdOEmp
        )
        SELECT
            1,              -- Черновик
            GETDATE(),
            IdSMeas,
            @IdEmp
        FROM inserted;


        RETURN;
    END;


    ----------------------------------------------------------------
    -- UPDATE: изменение плана
    ----------------------------------------------------------------
    IF UPDATE(DateSMeas) OR UPDATE(IdODocIn)
    BEGIN

        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            INNER JOIN dbo.tblDocIn d
                ON d.IdDocIn = i.IdODocIn
            INNER JOIN dbo.tSMeasStatus s
                ON s.IdOSMeasPlan = i.IdSMeas
               AND s.IdOStatus = 1
            WHERE i.DateSMeas < d.DateIn
               OR YEAR(i.DateSMeas) <> YEAR(s.DateStatus)
               OR i.DateSMeas < DATEADD(DAY,-10,s.DateStatus)
               OR i.DateSMeas > DATEADD(DAY,10,s.DateStatus)
        )
        BEGIN
            RAISERROR
            (
                N'Дата плана должна быть не ранее входящего документа, в пределах одного года и ±10 дней от даты черновика.',
                16,
                1
            );

            ROLLBACK TRANSACTION;
            RETURN;
        END;

    END;

END;
GO
CREATE TRIGGER dbo.tr_tSMeasPlan_DateCheck
ON dbo.tSMeasPlan
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DateDraft datetime;
    DECLARE @IdEmp int;

    -- Определяем сотрудника
    SELECT @IdEmp = e.IdEmployee
    FROM dbo.tblEmployee e
    WHERE e.lgn = SYSTEM_USER;


    -- Создание нового плана
    IF NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        -- Создаем статус Черновик
        INSERT INTO dbo.tSMeasStatus
        (
            IdOStatus,
            DateStatus,
            IdOSMeasPlan,
            IdOEmp
        )
        SELECT
            1,              -- Черновик
            GETDATE(),
            IdSMeas,
            @IdEmp
        FROM inserted;


        -- Проверяем дату относительно входящего документа
        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            INNER JOIN dbo.tblDocIn d
                ON d.IdDocIn = i.IdODocIn
            WHERE i.DateSMeas < d.DateIn
        )
        BEGIN
            RAISERROR
            (
                N'Дата плана не может быть ранее даты входящего документа.',
                16,
                1
            );

            ROLLBACK TRANSACTION;
            RETURN;
        END;

        RETURN;
    END;


    -- Изменение существующего плана
    IF UPDATE(DateSMeas)
    BEGIN

        SELECT @DateDraft = s.DateStatus
        FROM dbo.tSMeasStatus s
        INNER JOIN inserted i
            ON i.IdSMeas = s.IdOSMeasPlan
        WHERE s.IdOStatus = 1;


        IF @DateDraft IS NULL
            SET @DateDraft = GETDATE();


        IF EXISTS
        (
            SELECT 1
            FROM inserted i
            INNER JOIN dbo.tblDocIn d
                ON d.IdDocIn = i.IdODocIn
            WHERE i.DateSMeas < d.DateIn
               OR YEAR(i.DateSMeas) <> YEAR(@DateDraft)
               OR i.DateSMeas < DATEADD(DAY,-10,@DateDraft)
               OR i.DateSMeas > DATEADD(DAY,10,@DateDraft)
        )
        BEGIN
            RAISERROR
            (
                N'Недопустимая дата плана. Разрешено изменение только в пределах ±10 дней от даты черновика.',
                16,
                1
            );

            ROLLBACK TRANSACTION;
            RETURN;
        END;

    END;

END;
GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSMeasPlan] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasPlan] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSMeasPlan] TO [Expert]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSMeasPlan] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSMeasPlan] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasPlan] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSMeasPlan] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSMeasPlan] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasPlan] TO PUBLIC
    AS [dbo];

