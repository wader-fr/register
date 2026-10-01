CREATE TABLE [dbo].[tDocOut] (
    [IdDocOut]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [NumDocOut]         AS            (((CONVERT([nvarchar](50),[ANumDocOut],(0))+'-')+[Suffics])+case when [OutAA]=(1) then '/в' else '' end),
    [ANumDocOut]        INT           NULL,
    [Suffics]           CHAR (2)      NULL,
    [DateDocOut]        DATETIME      NULL,
    [YearOut]           CHAR (10)     NULL,
    [Note]              VARCHAR (MAX) NULL,
    [IdODocOut]         BIGINT        NULL,
    [ResigningNum]      VARCHAR (50)  NULL,
    [ResigningDate]     DATETIME      NULL,
    [NoEx]              BIT           CONSTRAINT [DF_tblDocOut_NoExec] DEFAULT ((0)) NOT NULL,
    [IdODocIn]          BIGINT        NULL,
    [IdOExpType]        INT           NULL,
    [IdOTypeDocOut]     INT           NULL,
    [IdOObject]         BIGINT        NULL,
    [IdOTypeObj]        INT           NULL,
    [IdOReconstruction] INT           NULL,
    [IdODept]           INT           NULL,
    [IdOEmp]            INT           NULL,
    [IdOResult]         SMALLINT      NULL,
    [Usr]               VARCHAR (50)  CONSTRAINT [DF_tblDocOut_Usr] DEFAULT (user_name()) NULL,
    [HostName]          VARCHAR (15)  CONSTRAINT [DF_tblDocOut_HostName] DEFAULT (host_name()) NULL,
    [DateAdded]         DATETIME      CONSTRAINT [DF_tblDocOut_DateAdded] DEFAULT (getdate()) NULL,
    [NameAttach]        VARCHAR (50)  NULL,
    [NameFile]          VARCHAR (250) NULL,
    [PathFile]          VARCHAR (250) NULL,
    [SelectionPlace]    VARCHAR (MAX) NULL,
    [DateInspB]         DATETIME      NULL,
    [DateInspE]         DATETIME      NULL,
    [IdOObjectInsp]     BIGINT        NULL,
    [NumProt]           VARCHAR (50)  NULL,
    [DateProt]          DATETIME      NULL,
    [Attestat]          VARCHAR (50)  NULL,
    [PathScan]          VARCHAR (MAX) NULL,
    [ScanName]          VARCHAR (250) NULL,
    [DateSent]          DATETIME      NULL,
    [Sent]              BIT           CONSTRAINT [DF_tDocOut_Sent] DEFAULT ((0)) NULL,
    [noTLC]             BIT           CONSTRAINT [DF_tDocOut_noTLC] DEFAULT ((0)) NULL,
    [OutAA]             BIT           CONSTRAINT [DF_tDocOut_OutAA] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_tblDocOut] PRIMARY KEY CLUSTERED ([IdDocOut] ASC),
    CONSTRAINT [FK_tDocOut_tblDocIn] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tdUpdDocOut]
   ON  dbo.tDocOut
   AFTER UPDATE
AS 
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @IdDept int
			,@IdEmp Int
			,@IdObj int
			,@DateDocOut datetime
			,@IdDocIn bigint
			,@DateEnd datetime

	SELECT @IdDept = i.IdODept, @IdEmp = i.IdOEmp, @IdObj = i.IdOObject , @DateDocOut = i.DateDocOut, @IdDocIn = i.IdODocIn
	FROM inserted i

	IF @IdObj  IS NOT NULL
	BEGIN
		UPDATE tblObject
		SET IdODept = @IdDept, IdOEmp = @IdEmp, DateEnd = @DateDocOut
		WHERE (IdObject = @IdObj)
	END
	IF EXISTS(SELECT * FROM dbo.tblObject o WHERE o.IdODocIn = @IdDocIn) AND
		NOT EXISTS(SELECT * FROM dbo.tblObject o WHERE o.IdODocIn = @IdDocIn AND o.DateEnd IS NULL)
	BEGIN
		SELECT @DateEnd = MAX(o.DateEnd)
		FROM dbo.tblObject o
		WHERE o.IdODocIn = @IdDocIn

		UPDATE dbo.tblDocIn
		SET DateEnd = @DateEnd
		WHERE IdDocIn = @IdDocIn
	END
END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tgADocOut]
   ON  dbo.tDocOut
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	IF EXISTS (SELECT *
				FROM dbo.tDocOut do
						INNER JOIN dbo.tblDocTypeOut dto ON dto.IdDocTypeOut = do.IdOTypeDocOut
				WHERE dto.AutoNumGroup IS NOT NULL
					AND do.DateDocOut BETWEEN '11.01.2022' AND DATEADD(d, -7, GETDATE())
					AND do.ScanName IS NULL
					AND do.Usr = USER_NAME())
		BEGIN
			RAISERROR ('Имеются задолженности по сканам документов свыше семи дней. Добавление новых документов заблокировано', 16, 1)
			ROLLBACK TRAN
		END
END

GO
DISABLE TRIGGER [dbo].[tgADocOut]
    ON [dbo].[tDocOut];


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1560, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1695, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ANumDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'DateDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'YearOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'ResigningDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'106', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'NoEx';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1417, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeDocOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tDocOut', @level2type = N'COLUMN', @level2name = N'IdOResult';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tDocOut] TO [SenderFGIS]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tDocOut] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tDocOut] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [SenderFGIS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tDocOut] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tDocOut] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tDocOut] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tDocOut] TO [Expert]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tDocOut] TO [Admin]
    AS [dbo];

