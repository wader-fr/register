-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[u2Etap] 
--DECLARE 
	@IdDoc bigint = 74051,
	@IdsEmp varchar(max) = ' '
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @IdsDeptN varchar(max), --Список кодов добавляемых подразделений
			@IdsDeptO varchar(max), --Список кодов удаляемых подразделений
			@IdsDept varchar(max) = NULL, --Итоговый список кодов подразделений 
			@Depts varchar(max), --Список подразделений
			@IdsEmpN varchar(4000), --Список кодов добавляемых исполнителей
			@IdsEmpO varchar(4000), --Список кодов удаляемых исполнителей
			@Emps varchar(max), --Список исполнителей
			@IdEtap int = 2 --Изменяемый этап
	DECLARE @MaxEtap int --Счетчик этапов(@Etap int, )
	DECLARE @IdDept int, @IdEmp int --Коды подразделения и исполнителя изменений
	DECLARE @User sysname = USER_NAME() -- логин исполнителя для определения ИД подразделения и исполнителя
	
	SELECT @IdDept = e.IdODept, @IdEmp = e.IdEmployee FROM [dbo].[tblEmployee] e WHERE e.lgn = @User --определение ИД подразделения и исполнителя
	
	SELECT @IdsDept = ' ' + CONVERT(varchar(10), e.IdODept) + ' ' FROM dbo.tblEmployee e WHERE e.lgn = @User AND e.Roles NOT LIKE '%Admin%'

	SELECT @MaxEtap = COUNT(*) FROM [dbo].[tAppointment] a WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp >= @IdEtap

	IF @MaxEtap = 0
		BEGIN
			SET @IdsDeptN = dbo.fnDeptOverEmp(@IdsEmp)
			SET @Depts = [dbo].[fnDeptList](@IdsDeptN)
			SET @Emps = [dbo].[fnEmpList](@IdsEmp)
			
			INSERT INTO [dbo].[tAppointment](IdODoc, IdOEmp, IdODept, IdOTypeApp, Depts, IdsDept, Emps, IdsEmp, DateExec)
				VALUES (@IdDoc, @IdEmp, @IdDept, @IdEtap, @Depts, @IdsDeptN, @Emps, @IdsEmp, GETDATE())
		END 
	ELSE
		BEGIN
			SELECT @IdsDeptO = a.IdsDept, @IdsEmpO = a.IdsEmp
			FROM [dbo].[tAppointment] a
			WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdEtap

			IF @IdsDept IS NULL
				SELECT @IdsDept = a.IdsDept
				FROM [dbo].[tAppointment] a
				WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = 1

			SET @IdsEmpN = dbo.fnEmpForDept(@IdsDept, @IdsEmp, @IdsEmpO)
			SET @IdsDeptN = dbo.fnDeptOverEmp(@IdsEmpN)
			SET @Depts = [dbo].[fnDeptList](@IdsDeptN)
			SET @Emps = [dbo].[fnEmpList](@IdsEmpN)
			IF @IdsDeptN IS NULL OR @IdsEmpN IS NULL
				DELETE FROM [dbo].[tAppointment]
				WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
			ELSE
				UPDATE [dbo].[tAppointment]
				SET IdsDept = @IdsDeptN, IdsEmp = @IdsEmpN, Depts = @Depts, Emps = @Emps, IdODept = @IdDept, IdOEmp = @IdEmp
				WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap

		END
			WHILE @IdEtap < = @MaxEtap
				BEGIN
					SET @IdEtap = @IdEtap + 1

					SELECT @IdsDeptO = a.IdsDept, @IdsEmpO = a.IdsEmp
					FROM [dbo].[tAppointment] a
					WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdEtap
					
					SET @IdsEmpN = dbo.fnEmpDel(@IdsDept, @IdsEmpO, @IdsEmp)
					SET @IdsDeptN = dbo.fnDeptOverEmp(@IdsEmpN)

					SET @Depts = [dbo].[fnDeptList](@IdsDeptN)
					SET @Emps = [dbo].[fnEmpList](@IdsEmpN)

					IF @IdsDeptN IS NULL OR @IdsEmpN IS NULL
						DELETE FROM [dbo].[tAppointment]
						WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
					ELSE
						UPDATE [dbo].[tAppointment]
						SET IdsDept = @IdsDeptN, IdsEmp = @IdsEmpN, Depts = @Depts, Emps = @Emps
						WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
				END
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u2Etap] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u2Etap] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u2Etap] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u2Etap] TO [Admin]
    AS [dbo];

