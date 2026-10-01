CREATE FUNCTION [dbo].[fnAbbr] (
--DECLARE 
@Str varchar(150)
) RETURNS varchar(10) AS
BEGIN
DECLARE @pos int = 0
		,@Im varchar
		,@Collect varchar(10) = ''

	SET @Str = dbo.fnStrNorm(@Str, 0, 1)
	SET @Str = REPLACE(@Str, ' и ', ' ')
	SET @Str = REPLACE(@Str, ' с ', ' ')
	SET @Str = REPLACE(@Str, ' в ', ' ')

		WHILE 1 = 1
			BEGIN
				SET @Im = SUBSTRING(@Str, @Pos + 1, 1)
				SET @Collect = @Collect + UPPER(@Im)
				SET @pos = CHARINDEX(' ', @Str, @pos + 1)
				IF @pos = 0
					BREAK
			END

		RETURN @Collect
END
