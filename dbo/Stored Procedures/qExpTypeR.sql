-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qExpTypeR]

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table(IdExpType int, ExpType varchar(150))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT e.IdExpType, e.ExpType
	FROM dbo.tblExp e

	SELECT * FROM @tbl

END
