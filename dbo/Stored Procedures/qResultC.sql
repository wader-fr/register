-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qResultC] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT r.IdResult, r.Result
	FROM dbo.tblResult r

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qResultC] TO [Admin]
    AS [dbo];

