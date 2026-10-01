-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uResinginDoc]
	--DECLARE
	@IdDocOut bigint
	,@IdDocOutR bigint
AS
BEGIN

	SET NOCOUNT ON;

	UPDATE dbo.tDocOut
	SET IdODocOut = @IdDocOutR
	WHERE IdDocOut= @IdDocOut

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uResinginDoc] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uResinginDoc] TO [Admin]
    AS [dbo];

