CREATE FUNCTION [dbo].[fnTypeDocInIdR]
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
	SELECT ROW_NUMBER() OVER(ORDER BY ordr) pos, dt.IdDocType FROM dbo.tblDocType dt WHERE dt.Act = 1 ORDER BY dt.Ordr

	SELECT @Result = Id FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
