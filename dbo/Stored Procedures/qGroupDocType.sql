-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qGroupDocType]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT gdt.IdGroupDocType, gdt.GroupDocType
	FROM dbo.tblGroupDocType gdt
	ORDER BY gdt.GroupDocType

END
