CREATE FUNCTION [dbo].[fnBudgetIdR] 
(
	@Pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (pos int, IdBudget int)

	INSERT INTO @tbl
	VALUES (0, 0)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdBudget) pos, b.IdBudget
	FROM dbo.tblBudget b
	ORDER BY b.IdBudget

	SELECT @Result = IdBudget FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnBudgetIdR] TO PUBLIC
    AS [dbo];

