-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qContFind]
--DECLARE
	@Name varchar(300) = NULL
	,@IdContragent bigint = NULL
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @tbl table (IdContragent int, Contragent varchar(max));

		

	IF @Name IS NOT NULL
			BEGIN
				SET @Name = dbo.fnFindIndex(@Name, '%');

				INSERT INTO @tbl
				VALUES (0,'<<<Добавить...>>>');
				
				INSERT INTO @tbl
				SELECT c.IdContragent, c.fName + ', ' + ISNULL(c.pAddress,'без адреса') + ', (' + tc.TypeContr + ')'
				FROM dbo.tblContragent c
						LEFT OUTER JOIN dbo.tblProp p ON c.IdOProperty = p.IdProperty
						LEFT OUTER JOIN dbo.tblTypeContr tc ON c.IdOTypeContr = tc.IdTypeContr
				WHERE c.fName LIKE @Name OR c.sName LIKE @Name
						OR ISNULL(c.pAddress, '') LIKE @Name
						OR c.IdContragent = @IdContragent;
			END
	ELSE IF @IdContragent IS NOT NULL
			BEGIN
				INSERT INTO @tbl
				VALUES (0,'<<<Добавить...>>>');

				INSERT INTO @tbl
				SELECT c.IdContragent, c.fName + ', ' + ISNULL(c.pAddress,'без адреса') + ', (' + tc.TypeContr + ')'
				FROM dbo.tblContragent c
						LEFT OUTER JOIN dbo.tblProp p ON c.IdOProperty = p.IdProperty
						LEFT OUTER JOIN dbo.tblTypeContr tc ON c.IdOTypeContr = tc.IdTypeContr
				WHERE c.IdContragent = @IdContragent;
			END

	SELECT * FROM @tbl;
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContFind] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContFind] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContFind] TO [Admin]
    AS [dbo];

