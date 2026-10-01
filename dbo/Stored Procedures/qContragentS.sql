-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qContragentS]
	@IdContragent bigint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT c.IdContragent
			,c.IdOTypeContr
			,c.IdOProperty
			,c.fName
			,c.sName
			,c.pAddress
			,c.pAddressC
			,c.LastName
			,c.FirstName
			,c.Patronimic
	FROM dbo.tblContragent c
	WHERE c.IdContragent = @IdContragent

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContragentS] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContragentS] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContragentS] TO [Admin]
    AS [dbo];

