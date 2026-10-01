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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupDocType] TO [Admin]
    AS [dbo];

