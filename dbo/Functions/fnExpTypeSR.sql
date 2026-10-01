CREATE FUNCTION [dbo].[fnExpTypeSR] 
(
	@Pos int
)
RETURNS varchar(300)
AS
BEGIN

	DECLARE @Result varchar(300)
	DECLARE @tbl table (pos int, ExpType varchar(300))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdExpType) pos, e.ExpType
	FROM dbo.tblExp e
	ORDER BY e.IdExpType

	SELECT @Result = ExpType FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnExpTypeSR] TO PUBLIC
    AS [dbo];

