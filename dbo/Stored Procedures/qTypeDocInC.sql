-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeDocInC]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT dt.IdDocType, dt.DocType, dt.IdOService, dt.Insp, dt.sDocType
	FROM dbo.tblDocType dt
	WHERE dt.Act = 1
	ORDER BY dt.Ordr

END
