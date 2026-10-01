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
