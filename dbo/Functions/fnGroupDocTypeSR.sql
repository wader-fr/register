CREATE FUNCTION [dbo].[fnGroupDocTypeSR] 
(
	@Pos int
)
RETURNS varchar(20)
AS
BEGIN

	DECLARE @Result varchar(20)
	DECLARE @tbl table (pos int, GroupDocType varchar(20))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdGroupDocType) pos, gt.GroupDocType
	FROM dbo.tblGroupDocType gt
	ORDER BY gt.IdGroupDocType

	SELECT @Result = GroupDocType FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnGroupDocTypeSR] TO PUBLIC
    AS [dbo];

