-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aProp]
	@Property varchar(10)
	,@IdProperty int OUT
AS
BEGIN

	SET NOCOUNT ON;

	SET @Property = REPLACE(@Property, '"', '')
	SET @Property = REPLACE(@Property, CHAR(10), ' ')
	SET @Property = REPLACE(@Property, CHAR(13), ' ')
	SET @Property = REPLACE(@Property, CHAR(9), ' ')
	SET @Property = REPLACE(@Property, '(-)', '')
	SET @Property = REPLACE(@Property, '-', '')
	SET @Property = REPLACE(@Property, '()', '')

	WHILE CHARINDEX('  ',@Property)>0
		BEGIN
			SET @Property = REPLACE(@Property,'  ',' ')
		END

	SET @Property = UPPER(LTRIM(RTRIM(@Property)))

	INSERT INTO dbo.tblProp (Property)
	VALUES (@Property)

	SET @IdProperty = @@IDENTITY

END
