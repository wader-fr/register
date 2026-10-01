CREATE FUNCTION [dbo].[fnDeptIdR] 
(
	@Pos int
	,@IdFilial int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (pos int, IdDept int)

	INSERT INTO @tbl
	VALUES (0, 0)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdDept) pos, d.IdDept
	FROM dbo.tblDept d
	WHERE d.Act = 1
		AND d.IdOFilial = @IdFilial
	ORDER BY d.IdDept

	SELECT @Result = IdDept FROM @tbl WHERE pos = @Pos

	RETURN @Result

END
