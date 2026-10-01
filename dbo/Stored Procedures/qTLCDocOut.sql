-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTLCDocOut]
	--DECLARE
	@IdDocOut BIGINT
	,@IdProt bigint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT t.IdTLCDocOut, t.IdODocOut, t.IdOEmp, t.IdOProtocol
	FROM dbo.tTLCDocOut t
	WHERE t.IdODocOut = @IdDocOut AND t.IdOProtocol = @IdProt

END
