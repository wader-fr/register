CREATE VIEW [dbo].[vContragent]
AS
SELECT        IdContragent, IdOProperty, sName, fName, pAddress, jAddress, pAddressC, jAddressC, IdOTypeContr, FirstName, Patronimic, LastName, Usr, HostName, DateAdded
FROM            dbo.tblContragent

GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\roman.CGIE\AppData\Local\Temp\~vs8F41.sql
CREATE TRIGGER [tgInstContrIns]
ON [dbo].[vContragent]
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @sName VARCHAR(50)
			,@fName VARCHAR(300)
			,@LastName VARCHAR(50)
			,@FirstName VARCHAR(50)
			,@Patronimic VARCHAR(50)
			,@IdTypeContr INT
			,@IdProperty INT


	SELECT	@sName = i.sName
			,@fName = i.fName
			,@LastName = i.LastName
			,@FirstName = i.FirstName
			,@Patronimic = i.Patronimic
			,@IdTypeContr = i.IdOTypeContr
			,@IdProperty = i.IdOProperty
	FROM INSERTED i

	IF @sName IS NOT NULL SET @sName = dbo.fnStrNorm(@sName, 0, 0)
	IF @fName IS NOT NULL SET @fName = dbo.fnStrNorm(@fName, 0, 1)
	IF @LastName IS NOT NULL SET @LastName = dbo.fnStrNorm(@LastName, 1, 1)
	IF @FirstName IS NOT NULL SET @FirstName = dbo.fnStrNorm(@FirstName, 1, 1)
	IF @Patronimic IS NOT NULL SET @Patronimic = dbo.fnStrNorm(@Patronimic, 1, 1)

	IF @IdTypeContr = 1 OR CHARINDEX('Роспотребнадзор', @sName) > 0 OR CHARINDEX('Роспотребнадзор', @fName) > 0
		BEGIN
			RAISERROR ('Никаких "Роспотребнадзоров"!!!', 16, 1)
			ROLLBACK TRANSACTION
		END
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ELSE IF @IdTypeContr = 3
		BEGIN
			SET @fName = 'ИП ' + @LastName + ' ' + ISNULL(@FirstName,'') + ' ' + ISNULL(@Patronimic,'')
			SET @sName = dbo.fnInitial(@LastName + ' ' + ISNULL(@FirstName,'') + ' ' + ISNULL(@Patronimic,''))

			IF NOT EXISTS(SELECT * FROM dbo.tblProp p WHERE p.Property = 'ИП')
				INSERT INTO dbo.tblProp (Property) VALUES ('ИП')

			SELECT @IdProperty = p.IdProperty FROM dbo.tblProp p WHERE p.Property = 'ИП'
		END
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ELSE IF @IdTypeContr = 4
		BEGIN
			SET @fName = 'ФЛ ' + @LastName + ' ' + ISNULL(@FirstName,'') + ' ' + ISNULL(@Patronimic,'')
			SET @sName = dbo.fnInitial(@LastName + ' ' + ISNULL(@FirstName,'') + ' ' + ISNULL(@Patronimic,''))

			IF NOT EXISTS(SELECT * FROM dbo.tblProp p WHERE p.Property = 'ФЛ')
				INSERT INTO dbo.tblProp (Property) VALUES ('ФЛ')

			SELECT @IdProperty = p.IdProperty FROM dbo.tblProp p WHERE p.Property = 'ФЛ'
		END
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ELSE
			SELECT @fName = ISNULL(@fName, p.Property + ' "' + @sName + '"')
			FROM inserted i LEFT OUTER JOIN dbo.tblProp p ON p.IdProperty = i.IdOProperty

	INSERT INTO tblContragent (IdOProperty, sName, fName, pAddress, pAddressC, IdOTypeContr, FirstName, Patronimic, LastName)
	SELECT @IdProperty
			,@sName
			,@fName
			,pAddress
			,pAddressC
			,@IdTypeContr
			,@FirstName
			,@Patronimic
			,@LastName
	FROM INSERTED

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[vContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vContragent] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vContragent] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vContragent] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[vContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[vContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[vContragent] TO [Admin]
    AS [dbo];

