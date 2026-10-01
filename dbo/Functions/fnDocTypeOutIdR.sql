CREATE FUNCTION [dbo].[fnDocTypeOutIdR]
(
	@pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table(pos int, IdDocTypeOut int)

	INSERT INTO @tbl
	VALUES (0,0),(1,-1)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY IdDocTypeOut) + 1 pos, dto.IdDocTypeOut
	FROM dbo.tblDocTypeOut dto
	ORDER BY dto.IdDocTypeOut

	SELECT @Result = IdDocTypeOut FROM @tbl WHERE pos = @pos

	RETURN @Result

END
