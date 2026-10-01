CREATE FUNCTION [dbo].[fnTypeWorkIdR]
(
	@Pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (Pos int, Id int)


	INSERT @tbl
	VALUES (0,0)

	INSERT @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY IdWorkType) pos, wt.IdWorkType FROM dbo.tblWorkType wt ORDER BY wt.IdWorkType

	SELECT @Result = Id FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
