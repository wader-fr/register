-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qGroupWorkType] 
AS
BEGIN

	SET NOCOUNT ON;

	SELECT gwt.IdGroupWorkType, gwt.GroupWorkType
	FROM dbo.tblGroupWorkType gwt
	ORDER BY gwt.GroupWorkType

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupWorkType] TO [Admin]
    AS [dbo];

