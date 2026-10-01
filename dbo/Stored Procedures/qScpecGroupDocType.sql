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
