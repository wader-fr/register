-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qScpecGroupDocType] 
	@Id int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
	FROM dbo.tblSpecGroupDocType sgdt
	WHERE sgdt.IdOGroupDocType = @Id

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qScpecGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qScpecGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qScpecGroupDocType] TO [Admin]
    AS [dbo];

