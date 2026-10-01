-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeDocOutC]

AS
BEGIN

	SET NOCOUNT ON;

	SELECT dto.IdDocTypeOut, dto.DocTypeOut, dto.AutoNumGroup
	FROM dbo.tblDocTypeOut dto
	ORDER BY dto.AutoNumGroup desc

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocOutC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocOutC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocOutC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocOutC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocOutC] TO [Admin]
    AS [dbo];

