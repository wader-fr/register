-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnProtConvert]
(
	@NumProt nvarchar(4000)
)
RETURNS nvarchar(4000)
AS
BEGIN

	DECLARE @ScanLIS nvarchar(500)
			,@ScanEIAS nvarchar(500)
			,@PrefixEIAS nvarchar(10)

			SET @ScanLIS = dbo.fnGetOption('ScanLIS')
			SET @ScanEIAS = dbo.fnGetOption('ScanEIAS')
			SET @PrefixEIAS = dbo.fnGetOption('PrefixEIAS')
			WHILE CHARINDEX(' ', @NumProt) > 0
				SET @NumProt = REPLACE(@NumProt,' ','')

	IF CHARINDEX(@PrefixEIAS, @NumProt, 1) >0
		BEGIN
			SET @NumProt = REPLACE(@NumProt, '-' + @PrefixEIAS,':')
			SET @NumProt = REPLACE(@NumProt, @PrefixEIAS,'')
			SET @NumProt = REPLACE(@NumProt, '-','.')
			SET @NumProt = REPLACE(@NumProt, ',',', ')
			SET @NumProt = REPLACE(@NumProt, ':',' - ')
			SET @NumProt = @ScanEIAS + '\' + @NumProt
		END
	ELSE
			SET @NumProt = @ScanLIS + '\' + @NumProt
		
	RETURN @NumProt + '.pdf'

END
