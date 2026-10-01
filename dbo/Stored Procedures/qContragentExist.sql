-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qContragentExist]
--	DECLARE
	@Name varchar(400)
AS
BEGIN

	SET NOCOUNT ON;

	SET @Name = dbo.fnFindIndex(@name, '%');

	SELECT ISNULL(c.fName,'') + ', ' + ISNULL(c.pAddress,'Без адреса')
	FROM dbo.tblContragent c
	WHERE c.fName LIKE @Name
			OR c.sName LIKE @Name;

END
