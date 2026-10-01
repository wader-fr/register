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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSubDocIn] TO [Admin]
    AS [dbo];

