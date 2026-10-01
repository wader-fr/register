CREATE FUNCTION [dbo].[fnBudgetSR] 
(
	@Pos int
)
RETURNS varchar(6)
AS
BEGIN

	DECLARE @Result varchar(6)
	DECLARE @tbl table (pos int, Budget varchar(6))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdBudget) pos, b.Budget
	FROM dbo.tblBudget b
	ORDER BY b.IdBudget

	SELECT @Result = Budget FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
