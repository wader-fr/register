-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qSpecGroupWorkType]
	@Id int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
	FROM dbo.tblSpecGroupWorkType sgwt
	WHERE sgwt.IdOGroupWorkType = @Id
	ORDER BY sgwt.IdOWorkType

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSpecGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSpecGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSpecGroupWorkType] TO [Admin]
    AS [dbo];

