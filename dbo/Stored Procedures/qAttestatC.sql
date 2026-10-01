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
