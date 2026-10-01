-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qResultR]

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table (IdResult smallint, Result varchar(50))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT r.IdResult, r.Result
	FROM dbo.tblResult r

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultR] TO PUBLIC
    AS [dbo];

