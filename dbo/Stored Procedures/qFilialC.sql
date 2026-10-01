-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qFilialC]

AS
BEGIN

	SET NOCOUNT ON;

	SELECT f.IdFilial, f.FFilial
	FROM dbo.tblFilial f


END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qFilialC] TO [Admin]
    AS [dbo];

