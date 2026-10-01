CREATE FUNCTION [dbo].[fnGroupDocTypeIdR] 
(
	@Pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (pos int, IdGroupDocType int)

	INSERT INTO @tbl
	VALUES (0, 0)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdGroupDocType) pos, gt.IdGroupDocType
	FROM dbo.tblGroupDocType gt
	ORDER BY gt.IdGroupDocType

	SELECT @Result = IdGroupDocType FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
