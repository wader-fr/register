CREATE PROCEDURE [dbo].[qContractList]
	--DECLARE
	@IdContragent bigint

AS
BEGIN
	SET NOCOUNT ON;

	SELECT * 
	FROM dbo.tContract c
	WHERE c.IdOContragent = @IdContragent

END
