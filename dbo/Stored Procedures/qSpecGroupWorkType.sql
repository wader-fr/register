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
