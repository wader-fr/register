-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qSubDocIn]
--	DECLARE
	@IdDocIn bigint = 79070
AS
BEGIN

	SET NOCOUNT ON;
	declare @Path nvarchar(512) = [dbo].[fnGetPathDoc](@IdDocIn)


	SELECT 
		sdi.IdSubDocIn, 
		sdi.ANumSubDocIn, 
		sdi.NumSubDocIn, 
		sdi.DateSubDocIn, 
		sdi.NumSubDocInOut,
		sdi.DateSubDocInOut,
		sdi.IdODocIn,
		sdi.Scan,
		dbo.fnBuildPath(@Path, sdi.NumSubDocIn + '.pdf', null, null) PathScan
	FROM dbo.tSubDocIn sdi
	WHERE sdi.IdODocIn = @IdDocIn

END
