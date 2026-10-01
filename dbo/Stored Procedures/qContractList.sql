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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContractList] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContractList] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContractList] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContractList] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContractList] TO [Admin]
    AS [dbo];

