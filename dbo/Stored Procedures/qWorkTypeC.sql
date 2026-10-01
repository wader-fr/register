-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qWorkTypeC] 
	@Serv tinyint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT *
	FROM dbo.tblWorkType wt
	WHERE wt.IdOService = ISNULL(@serv, wt.IdOService)
	ORDER BY wt.IdOService

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qWorkTypeC] TO PUBLIC
    AS [dbo];

