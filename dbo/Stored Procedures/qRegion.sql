-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qRegion]
	--DECLARE
AS
BEGIN

	SET NOCOUNT ON;

	SELECT r.CodeReg, r.FName
	FROM dbo.vRegion r
	ORDER BY r.FName

END
