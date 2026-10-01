CREATE FUNCTION [dbo].[fnTypeDocInSR]
(
	@Pos int
)
RETURNS varchar(75)
AS
BEGIN

	DECLARE @Result varchar(75)
	DECLARE @tbl table (Pos int, docType varchar(75))


	INSERT @tbl
	VALUES (0,'<Все>')

	INSERT @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY ordr) pos, dt.DocType FROM dbo.tblDocType dt WHERE dt.Act = 1 ORDER BY dt.Ordr

	SELECT @Result = docType FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnTypeDocInSR] TO PUBLIC
    AS [dbo];

