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
