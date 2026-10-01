-- =============================================
-- Author:		vader
-- Create date: 10/11/2025
-- Description:	Журнал планов отбора
-- =============================================
CREATE PROCEDURE qSelPlane 
--declare
@IdDocIn bigint,
	@IdEmp int, 
	@IdDept int
AS
BEGIN

	SET NOCOUNT ON;

	select *
	from dbo.tSelPlan sp
		inner join (
			select max(asp.IdOTypeAppSP) IdOTypeAppSel, asp.IdOSelPlan from dbo.tAppointmentSP asp group by asp.IdOSelPlan
		) a on a.IdOSelPlan = sp.IdSelPlan
		inner join dbo.tTypeAppSP tas on tas.IdTypeAppSP = a.IdOTypeAppSel
END
