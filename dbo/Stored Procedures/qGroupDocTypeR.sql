-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qGroupDocTypeR]

AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @tbl table (IdGroupDocType int, GroupDocType varchar(20))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT *
	FROM dbo.tblGroupDocType

	SELECT * FROM @tbl

END
