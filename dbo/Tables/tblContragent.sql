CREATE TABLE [dbo].[tblContragent] (
    [IdContragent] BIGINT        IDENTITY (1, 1) NOT NULL,
    [IdOProperty]  INT           NULL,
    [sName]        VARCHAR (50)  NULL,
    [fName]        VARCHAR (300) NULL,
    [pAddress]     VARCHAR (100) NULL,
    [jAddress]     VARCHAR (100) NULL,
    [pAddressC]    VARCHAR (50)  NULL,
    [jAddressC]    NVARCHAR (50) NULL,
    [IdOTypeContr] INT           NOT NULL,
    [FirstName]    VARCHAR (50)  NULL,
    [Patronimic]   VARCHAR (50)  NULL,
    [LastName]     VARCHAR (50)  NULL,
    [Usr]          VARCHAR (50)  CONSTRAINT [DF_tblContragent_Usr] DEFAULT (user_name()) NULL,
    [HostName]     VARCHAR (15)  CONSTRAINT [DF_tblContragent_HostName] DEFAULT (host_name()) NULL,
    [DateAdded]    DATETIME      CONSTRAINT [DF_tblContragent_DateAdded] DEFAULT (getdate()) NULL,
    [INN]          VARCHAR (12)  NULL,
    [OGRN]         VARCHAR (15)  NULL,
    CONSTRAINT [PK_tblContragent] PRIMARY KEY CLUSTERED ([IdContragent] ASC),
    CONSTRAINT [FK_tblContragent_tblProp] FOREIGN KEY ([IdOProperty]) REFERENCES [dbo].[tblProp] ([IdProperty]),
    CONSTRAINT [FK_tblTypeContragent_tblContragent] FOREIGN KEY ([IdOTypeContr]) REFERENCES [dbo].[tblTypeContr] ([IdTypeContr])
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[tgInstContrUpd]
   ON  [dbo].[tblContragent]
   INSTEAD OF UPDATE
AS 
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @IdContragent int
			,@sName varchar(50), @sNameOld varchar(50)
			,@fName varchar(300), @fNameOld varchar(300)
			,@LastName varchar(50)
			,@FirstName varchar(50)
			,@Patronimic varchar(50)
			,@IdOTypeContr int, @IdOTypeContrOld int
			,@IdOProperty int, @IdOPropertyOld int
			,@Inn varchar(12), @OGRN varchar(15)
	
	SELECT	@IdContragent = i.IdContragent
			,@sName = i.sName
			,@fName = i.fName
			,@LastName = dbo.fnStrNorm(i.LastName, 1, 1)
			,@FirstName = dbo.fnStrNorm(i.FirstName, 1, 1)
			,@Patronimic = dbo.fnStrNorm(i.Patronimic, 1, 1)
			,@IdOTypeContr = i.IdOTypeContr
			,@IdOProperty = i.IdOProperty
			,@Inn = i.INN
			,@OGRN = i.OGRN
	FROM INSERTED i

	SELECT @sNameOld = d.sName
			,@fNameOld = d.fName
			,@IdOTypeContrOld = d.IdOTypeContr
			,@IdOPropertyOld = d.IdOProperty
	FROM deleted d

	IF @sName <> @sNameOld AND @fName = @fNameOld 
		SET @fName = NULL
	ELSE IF @IdOTypeContr <> @IdOTypeContrOld AND @fName = @fNameOld
		SET @fName = NULL
	ELSE IF @IdOProperty <> @IdOPropertyOld AND @fName = @fNameOld
		SET @fName = NULL

	IF @IdOTypeContr = 1 OR CHARINDEX('Роспотребнадзор', @sName) > 0 OR CHARINDEX('Роспотребнадзор', @fName) > 0
		BEGIN
			RAISERROR ('Никаких "Роспотребнадзоров"!!!', 16, 1)
			ROLLBACK TRANSACTION
		END

	ELSE IF @IdOTypeContr = 3
		BEGIN
			SET @fName = 'ИП ' + @LastName + ' ' + @FirstName + ' ' + @Patronimic
			SET @sName = dbo.fnInitial(@LastName + ' ' + @FirstName + ' ' + @Patronimic)

			IF NOT EXISTS (SELECT * FROM dbo.tblProp p WHERE p.Property = 'ИП')
				INSERT INTO dbo.tblProp (Property)
				VALUES ('ИП')

			SELECT @IdOProperty = p.IdProperty
			FROM dbo.tblProp p
			WHERE p.Property = 'ИП'
		END

	ELSE IF @IdOTypeContr = 4
		BEGIN
			SET @fName = 'ФЛ ' + @LastName + ' ' + @FirstName + ' ' + @Patronimic
			SET @sName = dbo.fnInitial(@LastName + ' ' + @FirstName + ' ' + @Patronimic)

			IF NOT EXISTS (SELECT	* FROM dbo.tblProp p WHERE p.Property = 'ФЛ')
				INSERT INTO dbo.tblProp (Property)
				VALUES ('ФЛ')

			SELECT @IdOProperty = p.IdProperty
			FROM dbo.tblProp p
			WHERE p.Property = 'ФЛ'
		END


	ELSE IF @IdOTypeContr <> 3 AND @IdOTypeContr <> 4
		BEGIN
			SET @sName = dbo.fnStrNorm(@sName, 0, 1)

			SELECT @fName = ISNULL(@fName, p.Property + ' "' + @sName + '"')
			FROM INSERTED i
					LEFT JOIN dbo.tblProp p ON i.IdOProperty = p.IdProperty

			SET @fName = dbo.fnStrNorm(@fName, 0, 0)
			SET @FirstName = NULL
			SET @Patronimic = NULL
			SET @LastName = NULL
		END

	UPDATE dbo.tblContragent 
	SET IdOProperty = @IdOProperty
		,sName = @sName
		,fName = @fName
		,pAddress = i.pAddress
		,pAddressC = i.jAddressC
		,IdOTypeContr = @IdOTypeContr
		,FirstName = @FirstName
		,Patronimic = @Patronimic
		,INN = @INN
		,OGRN = @OGRN
	,LastName = @LastName
	FROM inserted i
	WHERE tblContragent.IdContragent = @IdContragent
END

GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1755, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1417, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOProperty';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'sName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 3660, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'fName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 5895, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'pAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'jAddressC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'IdOTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'Patronimic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblContragent', @level2type = N'COLUMN', @level2name = N'LastName';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblContragent] TO PUBLIC
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblContragent] TO [guest]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblContragent] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [guest]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblContragent] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [guest]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblContragent] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblContragent] TO [guest]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblContragent] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblContragent] TO [Admin]
    AS [dbo];

