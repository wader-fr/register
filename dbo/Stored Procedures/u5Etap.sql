
-- =============================================
-- Author:		Roman
-- Create date: 27.02.2025
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[u5Etap]
--DECLARE
	@IdDoc bigint = 74051
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @IdDept varchar(20),
			@IdEmp varchar(20),
			@IdsDeptO varchar(500),
			@IdsDeptN varchar(500),
			@Depts varchar(max),
			@IdsEmpO varchar(1000),
			@IdsEmpN varchar(1000),
			@Emps varchar(max),
			@IdEtap int = 5

	
	SELECT @IdDept = ' ' + CONVERT(varchar(10), e.IdODept) + ' ', @IdEmp = ' ' + CONVERT(varchar(10),e.IdEmployee) + ' ' FROM dbo.tblEmployee e WHERE e.lgn = CURRENT_USER
	

	if exists(select * from [dbo].[tblEmployee] e where e.IdEmployee = @IdEmp and CHARINDEX('sampler', e.Roles) = 0)
		begin
			SELECT @IdsDeptO = a.IdsDept, @IdsEmpO = a.IdsEmp FROM dbo.tAppointment a WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdEtap
	
			IF @@ROWCOUNT = 0
				BEGIN
					SET @IdsDeptN = @IdDept 
					SET @IdsEmpN = @IdEmp
					SET @Depts = dbo.fnDeptList(@IdsDeptN)
					SET @Emps = dbo.fnEmpList(@IdsEmpN)
			
					INSERT INTO dbo.tAppointment (	IdODoc,  IdsDept,	IdsEmp,  IdODept, IdOEmp, Depts,  Emps,  IdOTypeApp, DateApp)
					VALUES (						@IdDoc, @IdsDeptN, @IdsEmpN,@IdDept, @IdEmp, @Depts, @Emps, @IdEtap,    GETDATE())
				END
	
			ELSE
				BEGIN
		
					SET @IdsDeptN = dbo.fnDeptAdd(@IdsDeptO, @IdDept)
					SET @IdsEmpN = dbo.fnEmpAdd(@IdsEmpO, @IdEmp)
					SET @Depts = dbo.fnDeptList(@IdsDeptN)
					SET @Emps = dbo.fnEmpList(@IdsEmpN)
			
					UPDATE dbo.tAppointment
					SET IdsDept = @IdsDeptN, IdsEmp = @IdsEmpN, Depts = @Depts, Emps = @Emps, IdODept = @IdDept, IdOEmp = @IdEmp, DateApp = GETDATE()
					WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
				END
			end
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u5Etap] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u5Etap] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u5Etap] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u5Etap] TO [Admin]
    AS [dbo];

