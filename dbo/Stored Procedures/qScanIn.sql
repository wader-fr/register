-- =============================================
-- Author:		Roman
-- Create date: 28.02.2025
-- Description:	Форма списка сканов к входящему №
-- =============================================
CREATE PROCEDURE [dbo].[qScanIn]
	@IdDoc bigint
AS
BEGIN
	
	SET NOCOUNT ON;

	declare @Path nvarchar(max) = [dbo].[fnGetPathDoc](@IdDoc)

	SELECT
		sdi.IdScanIn,
		sdi.IdODocIn,
		sdi.[Description],
		sdi.doc Scan,
		dbo.fnBuildPath(@Path, ISNULL(sdi.doc, sdi.[Description]), null, null) PathScan
	FROM dbo.tScanDocIn sdi 
	WHERE sdi.IdODocIn = @IdDoc

END