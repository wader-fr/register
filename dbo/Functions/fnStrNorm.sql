-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnStrNorm]
(
	@Str nvarchar(max)
	,@DelSpace bit
	,@DelQuotes bit
)
RETURNS nvarchar(max)
AS
BEGIN

	DECLARE @Result nvarchar(max)

	IF @Str IS NULL
		BEGIN
			SET @Result = ''
		END
		ELSE
			BEGIN
				IF @DelQuotes = 1 
					SET @Str = REPLACE(@Str, '"', '')

				SET @Str = REPLACE(@Str, '№ ', '№')
				SET @Str = REPLACE(@Str, CHAR(10), ' ')
				SET @Str = REPLACE(@Str, CHAR(13), ' ')
				SET @Str = REPLACE(@Str, CHAR(9), ' ')

				IF @DelSpace = 1
					SET @Str = REPLACE(@Str, ' ', '')
				ELSE
					BEGIN
						WHILE CHARINDEX('  ', @str) > 0
							BEGIN
								SET @str = REPLACE(@str, '  ', ' ')
							END
					END
				SET @Result = LTRIM(RTRIM(@Str))
			END


	RETURN @Result

END
