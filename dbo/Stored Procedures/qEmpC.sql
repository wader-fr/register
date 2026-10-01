-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpC] 
--	DECLARE
	@IdDept int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT e.IdEmployee, dbo.fnInitial(E.LastName  + ' ' + e.FirstName + ' ' + e.Patronimic), e.IdODept
	FROM dbo.tblEmployee e
	WHERE 
		e.IdODept = ISNULL(@IdDept, e.IdODept)
			AND
		e.Fired = 0
	ORDER BY 2

END
