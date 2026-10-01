CREATE FUNCTION [dbo].[fnEmpSR]
(
	@Pos int
	,@Dept int
)
RETURNS varchar(50)
AS
BEGIN

	DECLARE @Result varchar(50)
	DECLARE @tbl table (Pos int, FullName varchar(50))

	IF @Dept = 0 SET @Dept = NULL


	INSERT @tbl
	VALUES (0,'<Все>')

	INSERT @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY FullName) pos, e.FullName FROM dbo.tblEmployee e WHERE e.IdODept = ISNULL(@Dept, e.IdODept) AND e.Fired = 0 ORDER BY e.FullName

	SELECT @Result = FullName FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEmpSR] TO PUBLIC
    AS [dbo];

