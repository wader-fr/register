-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qPropC]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT p.IdProperty, p.Property
	FROM dbo.tblProp p
	WHERE p.Property NOT IN ('ИП', 'ФЛ')
	ORDER BY p.Property

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPropC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPropC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPropC] TO [Admin]
    AS [dbo];

