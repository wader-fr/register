CREATE FUNCTION [dbo].[fnDocTypeOutSR]
(
	@pos int
)
RETURNS varchar(300)
AS
BEGIN

	DECLARE @Result varchar(300)
	DECLARE @tbl table(pos int, DocTypeOut varchar(300))

	INSERT INTO @tbl
	VALUES (0,'<Все>'),(1,'<ФГИС>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER(ORDER BY IdDocTypeOut) + 1 pos, dto.DocTypeOut
	FROM dbo.tblDocTypeOut dto
	ORDER BY dto.IdDocTypeOut

	SELECT @Result = DocTypeOut FROM @tbl WHERE pos = @pos
	
	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDocTypeOutSR] TO PUBLIC
    AS [dbo];

