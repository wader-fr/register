-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qProtS]
	--DECLARE
	@IdDocOut bigint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT p.IdProt, p.NumProt, p.DateProt, p.Attestat, p.IdODocOut
	FROM dbo.tProtocol p
	WHERE p.IdODocOut = @IdDocOut

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qProtS] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qProtS] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qProtS] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qProtS] TO [Admin]
    AS [dbo];

