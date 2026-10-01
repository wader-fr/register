-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptT] 
AS
BEGIN
	SET NOCOUNT ON;

	WITH cte (IdDept, NameDept, PIdDept, Act, sNameDept) AS
	(
	SELECT d.IdDept, d.NameDept, d.PIdDept, d.Act, d.sNameDept
	FROM dbo.tblDept d
	WHERE d.PIdDept IS NULL 

	UNION ALL

	SELECT d.IdDept, d.NameDept, d.PIdDept, d.Act, d.sNameDept
	FROM dbo.tblDept d INNER JOIN cte ON d.PIdDept = cte.IdDept
	)

	SELECT * FROM cte
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDeptT] TO [Admin]
    AS [dbo];

