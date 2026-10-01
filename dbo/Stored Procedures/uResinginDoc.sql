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
