
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qProtRep]
	--DECLARE
	@IdDocOut INTEGER
AS
BEGIN

	SET NOCOUNT ON;

	SELECT p.IdProt, p.NumProt, p.DateProt, p.Attestat, dbo.fnProtConvert(p.NumProt) FileN
    FROM dbo.tProtocol AS p
    WHERE IdODocOut = @IdDocOut
END

