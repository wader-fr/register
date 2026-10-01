
CREATE PROCEDURE [dbo].[qDateAdd]
	--DECLARE 
	@Day int
	, @Date datetime
AS
BEGIN
	DECLARE @SQL nvarchar(MAX)

	IF @Day > 0 
		BEGIN
			SET @SQL = 'SELECT MAX(dd.DateD) DD FROM (SELECT TOP ' + CAST( @Day AS NVARCHAR(5)) + ' [DateD]
						FROM [dbo].[tCldr] 
						WHERE DateD >= '''+  CAST(@Date AS NVARCHAR(12)) + ''' ORDER BY DateD) as dd'
		END
	ELSE IF @Day < 0
		BEGIN 
			SET @Day = @day * -1
			SET @SQL = 'SELECT MIN(dd.DateD) DD FROM (SELECT TOP ' + CAST( @Day AS NVARCHAR(5)) + ' [DateD]
						FROM [dbo].[tCldr] 
						WHERE DateD <= '''+  CAST(@Date AS NVARCHAR(12)) + ''' ORDER BY DateD DESC) as dd'
		END

		EXEC (@SQL)
	END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDateAdd] TO PUBLIC
    AS [dbo];

