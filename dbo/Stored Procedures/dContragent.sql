-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[dContragent]
	@IdContragent int
AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM dbo.tblContragent
	WHERE IdContragent = @IdContragent

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[dContragent] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[dContragent] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[dContragent] TO [Admin]
    AS [dbo];

