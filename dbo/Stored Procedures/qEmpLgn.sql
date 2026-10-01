-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpLgn]
	@Lgn varchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT e.IdEmployee, d.IdOFilial, e.IdODept, f.SFilial, d.sNameDept, ddd.IdDept dept
	FROM dbo.tblEmployee e
			LEFT OUTER JOIN dbo.tblDept d ON e.IdODept = d.IdDept
			LEFT OUTER JOIN (SELECT * FROM dbo.tblDept dd WHERE dd.Act = 1) ddd ON e.IdODept = ddd.IdDept
			LEFT OUTER JOIN dbo.tblFilial f ON f.IdFilial = d.IdOFilial
	WHERE e.lgn = @Lgn and e.Fired = 0;

END
