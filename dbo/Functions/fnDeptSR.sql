CREATE FUNCTION [dbo].[fnDeptSR] 
(
	@Pos int
	, @IdFilial int
)
RETURNS varchar(10)
AS
BEGIN

	DECLARE @Result varchar(10)
	DECLARE @tbl table (pos int, sDept varchar(10))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdDept) pos, d.sNameDept
	FROM dbo.tblDept d
	WHERE d.Act = 1
		AND d.IdOFilial = @IdFilial
	ORDER BY d.IdDept

	SELECT @Result = sDept FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDeptSR] TO PUBLIC
    AS [dbo];

