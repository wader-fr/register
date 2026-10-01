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
