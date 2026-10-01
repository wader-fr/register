
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qAssignmentD]
	--declare
	@idDocIn int
AS
BEGIN

	SET NOCOUNT ON;

	select a.IdAssignment, a.IdODocIn, a.IdODept, a.Assignment, a.IdOEmpV
	from dbo.tAssignment a
	where a.IdODocIn = @idDocIn

END