-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnFindIndex] (@str VARCHAR(150),
@ValNull VARCHAR(1))
RETURNS VARCHAR(150)
AS
BEGIN

  DECLARE @ResultVar VARCHAR(150)

  IF ISNULL(@str, '') = ''
  BEGIN
    SET @ResultVar = ISNULL(@ValNull,'%')
  END
  ELSE
  BEGIN
    SET @str = REPLACE(@str, '"', '');
    SET @str = REPLACE(@str, '-', ' ')
    SET @str = REPLACE(@str, ',', ' ')
    SET @str = REPLACE(@str, '\', ' ')
    SET @str = REPLACE(@str, '/', ' ')
    SET @str = REPLACE(@str, '''', ' ')
    SET @str = REPLACE(@str, '.', ' ')
   WHILE CHARINDEX('  ', @str) > 0
    BEGIN
      SET @str = REPLACE(@str, '  ', ' ')
    END
    SET @ResultVar = '%' + REPLACE(@str, ' ', '%') + '%';
  END

  RETURN @ResultVar

END
