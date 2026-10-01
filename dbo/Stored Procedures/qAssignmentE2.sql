

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qAssignmentE2]
	--declare
	@IdDoc bigint
	,@idDept int
	,@ass varchar(50) out
AS
BEGIN

	SET NOCOUNT ON;

	select @ass = a.Assignment from dbo.tAssignment a where a.IdODocIn = @IdDoc and a.IdODept = @idDept and a.IdOEmp is null

	select a.IdAssignment, a.IdODocIn, a.IdOEmp, a.Assignment,a.IdODept
	from dbo.tAssignment a
	where a.IdODocIn = @IdDoc and a.IdODept = @idDept and a.IdOEmp is not null

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE2] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE2] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE2] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAssignmentE2] TO [Admin]
    AS [dbo];

