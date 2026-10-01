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
