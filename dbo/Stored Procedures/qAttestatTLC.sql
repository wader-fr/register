-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qAttestatTLC]
	--DECLARE
AS
BEGIN

	SET NOCOUNT ON;

	SELECT a.AttestatTLC, a.NameLab
	FROM dbo.tAttestatTLC a

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatTLC] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatTLC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatTLC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatTLC] TO [Admin]
    AS [dbo];

