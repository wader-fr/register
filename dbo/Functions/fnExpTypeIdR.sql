CREATE FUNCTION [dbo].[fnExpTypeIdR] 
(
	@Pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (pos int, IdExpType int)

	INSERT INTO @tbl
	VALUES (0, 0)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdExpType) pos, e.IdExpType
	FROM dbo.tblExp e
	ORDER BY e.IdExpType

	SELECT @Result = IdExpType FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnExpTypeIdR] TO PUBLIC
    AS [dbo];

