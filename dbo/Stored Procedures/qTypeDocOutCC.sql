-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeDocOutCC]
--	DECLARE
	@IdDocTypeOut int = NULL
	,@Group int = NULL
AS
BEGIN

	SET NOCOUNT ON;
	
	IF @Group IS NOT NULL SET @IdDocTypeOut = NULL

	SELECT dto.IdDocTypeOut, dto.DocTypeOut, dto.AutoNumGroup, dto.sDocTypeOut
	FROM dbo.tblDocTypeOut dto
	WHERE ISNULL(dto.AutoNumGroup, 0) = COALESCE(@Group, dto.AutoNumGroup, 0)
			AND dto.IdDocTypeOut = ISNULL(@IdDocTypeOut, dto.IdDocTypeOut)
	ORDER BY dto.AutoNum desc

END
