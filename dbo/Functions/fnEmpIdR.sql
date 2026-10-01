CREATE FUNCTION [dbo].[fnEmpIdR] 
(
	@Pos int
	,@Dept int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (Pos int, Id int)

	IF @Dept = 0 SET @Dept = NULL

	INSERT @tbl
	VALUES (0,0)

	INSERT @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY FullName) pos, e.IdEmployee FROM dbo.tblEmployee e WHERE e.IdODept = ISNULL(@Dept, e.IdODept) AND e.Fired = 0 ORDER BY e.FullName

	SELECT @Result = Id FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEmpIdR] TO PUBLIC
    AS [dbo];

