-- Batch submitted through debugger: SQLQuery6.sql|7|0|C:\Users\roman\AppData\Local\Temp\17\~vsDBAA.sql
-- =============================================
-- Author:		Roman
-- Create date: 07.02.2025
-- Description:	Изменение первого этапа и по цепочке
-- =============================================
CREATE PROCEDURE [dbo].[u1Etap]
--DECLARE
	@IdDoc bigint = 82264, 
	@IdsDept varchar(50) = ' 18 '
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @IdsDeptN varchar(150),			--Вновь назначенные отделы
			@IdsDeptO varchar(150),			--"Старые" отделы
			@Depts varchar(max)				--Список отделов (откорректированный)

	DECLARE @IdsEmpN varchar(150),			--Сотрудники, остающиеся в последующих этапах
			@IdsEmpO varchar(150),			--Сотруники последующих этапов, которых нужно чистить
			@Emps  varchar(max)				--Список сотрудников (откорректированный)

	DECLARE @IdDept int, @IdEmp int			--Отдел в котором работает сотрудник, проводивший коррекцию
	DECLARE @IdEtap int = 1, @MaxEtap int	--Счетчики этапов
	
	--Получаем ИД отдела-исполнителя
	SELECT @IdDept = e.IdODept, @IdEmp = e.IdEmployee FROM [dbo].[tblEmployee] e WHERE e.lgn = CURRENT_USER

	--Проверка количества этапов к данному документу
	SELECT @MaxEtap = COUNT(*) FROM [dbo].[tAppointment] a WHERE a.IdODoc = @IdDoc		

	SET @IdsDeptN = @IdsDept

	IF @MaxEtap = 0 --Если 0, значит это первое назначение, добавляем новую запись
		BEGIN
			--Получаем перечисление отделов по их кодам
			SET @Depts = [dbo].[fnDeptList](@IdsDeptN) 
			
			--Просто добавляем этап
			INSERT INTO [dbo].[tAppointment](IdODoc, IdOEmp, IdODept, IdOTypeApp, Depts, IdsDept, DateExec)
				VALUES (@IdDoc, @IdEmp, @IdDept, @IdEtap, @Depts, @IdsDept, GETDATE())
		END

	ELSE -- если этапов > 0 редактируем первый этап
		BEGIN
			SET @Depts = dbo.fnDeptList(@IdsDept)
			
			IF @IdsDeptN = ' '
				DELETE FROM dbo.tAppointment
				WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
			ELSE
				UPDATE dbo.tAppointment
				SET IdsDept = @IdsDept, IdOEmp = @IdEmp, IdODept = @IdDept, Depts = @Depts, DateExec = GETDATE()
				WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap

			WHILE @IdEtap < @MaxEtap
				BEGIN
					SET @IdEtap = @IdEtap + 1
					SELECT @IdsDeptO = a.IdsDept, @IdsEmpO = a.IdsEmp FROM dbo.tAppointment a WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdEtap
					SET @IdsDeptN = dbo.fnDeptIntersection(@IdsDept, @IdsDeptO)
					SET @IdsEmpN = dbo.fnEmpForDepts(@IdsDeptN, @IdsEmpO)
					SET @Depts = dbo.fnDeptList(@IdsDeptN)
					SET @Emps = dbo.fnEmpList(@IdsEmpN)
					
					IF @IdsDeptN IS NULL OR @IdsEmpN IS NULL
						DELETE FROM dbo.tAppointment WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
					ELSE
						UPDATE dbo.tAppointment
						SET IdsDept = @IdsDeptN, IdsEmp = @IdsEmpN, Depts=@Depts, Emps = @Emps
						WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap
				END


		END
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u1Etap] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u1Etap] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u1Etap] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[u1Etap] TO [Admin]
    AS [dbo];

