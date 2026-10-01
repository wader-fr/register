CREATE FUNCTION [dbo].[fnTypeWorkSR]
(
	@Pos int
)
RETURNS varchar(100)
AS
BEGIN

	DECLARE @Result varchar(100)
	DECLARE @tbl table (Pos int, WorkType varchar(100))


	INSERT @tbl
	VALUES (0,'<Все>')

	INSERT @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY IdWorkType) pos, wt.WorkType + ' (' + s.NameService + ')' FROM dbo.tblWorkType wt 
			INNER JOIN dbo.tblService s ON s.IdService = wt.IdOService
		ORDER BY wt.IdWorkType

	SELECT @Result = WorkType FROM @tbl WHERE Pos = @Pos

	RETURN @Result

END
