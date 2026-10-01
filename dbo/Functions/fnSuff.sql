-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fnSuff 
(

)
RETURNS char(2)
AS
BEGIN

	DECLARE @ResultVar char(2)

	SELECT @ResultVar = f.SFilial FROM dbo.tblFilial f where f.IdFilial = dbo.fnGetOption('Filial')

	RETURN @ResultVar

END
