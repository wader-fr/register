-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpApp] 
--	DECLARE
		@IdApp bigint
AS
	BEGIN

		SET NOCOUNT ON;

		SELECT ea.IdOApp, ea.DateApp, d.sNameDept, e.FullName, ta.TypeApp, ea.Depts, ea.Emps
		FROM dbo.tEmpApp ea
			INNER JOIN dbo.tblDept d ON d.IdDept = ea.IdODept
			INNER JOIN dbo.tblEmployee e ON e.IdEmployee = ea.IdOEmp
			INNER JOIN dbo.tTypeAppointment ta ON ta.IdTypeAppointment = ea.IdOTypeEtap
		WHERE ea.IdOApp = @IdApp
		ORDER BY ea.DateApp

	END
