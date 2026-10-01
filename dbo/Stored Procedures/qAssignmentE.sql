

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qAssignmentE]
--	declare
	@IdDoc bigint = 79064
	,@idDept int = 2
	,@idEmp int
	,@ass varchar(150) out
	,@Emp varchar(50) out
as
BEGIN

	SET NOCOUNT ON;


	select @ass = a.Assignment 
	from dbo.tAssignment a 
	where a.IdODocIn = @IdDoc and a.IdODept = @idDept and a.IdOEmp is null;

	select @Emp = e.FullName from dbo.tblEmployee e where e.IdEmployee = @idEmp


	select a.IdAssignment, a.IdODocIn, a.IdOEmp, a.Assignment, a.IdODept
	from dbo.tAssignment a
	where a.IdODocIn = @IdDoc and a.IdODept = @idDept and a.IdOEmp = @idEmp

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE] TO [Admin]
    AS [dbo];

