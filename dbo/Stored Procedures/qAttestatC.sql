-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qAttestatC]
	--DECLARE
AS
BEGIN

	SET NOCOUNT ON;

	SELECT a.AttestatTLC, a.NameLab
	FROM dbo.tAttestatTLC a

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatC] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttestatC] TO [Admin]
    AS [dbo];

