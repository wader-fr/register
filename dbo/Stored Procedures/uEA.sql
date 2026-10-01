
CREATE PROCEDURE [dbo].[uEA]
	--DECLARE
		@IdEmps nvarchar(200) = '6,7'
		,@IdDepts nvarchar(200) = NULL
		,@IdDoc bigint = 60011
		,@IdEmp int = 7
		,@IdTypeApp int = 2
AS
BEGIN
	
	DECLARE @IdApp bigint
			,@Emp nvarchar(50)
			,@Emps nvarchar(500) = ''
			,@l nvarchar(2)=''
			,@IdDept int;


	SELECT @IdDept = e.IdODept FROM dbo.tblEmployee e WHERE e.IdEmployee = @IdEmp;
	SELECT @IdApp =  a.IdAppointment FROM [dbo].[tAppointment] a WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdTypeApp AND a.IdODept = @IdDept;
	
	--SELECT e.IdODept FROM dbo.tblEmployee e WHERE e.IdEmployee = @IdEmp;
	--SELECT a.IdAppointment FROM [dbo].[tAppointment] a WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = @IdTypeApp AND a.IdODept = @IdDept;
	
			
	IF @IdApp IS NULL
		BEGIN
			INSERT INTO [dbo].[tAppointment] (IdODoc, IdOEmp, IdOTypeApp, DateExec, IdODept)
			VALUES (@IdDoc, @IdEmp, @IdTypeApp, GETDATE(), @IdDept);
			
			SET @IdApp = @@IDENTITY
		END
	
		
	IF @IdEmps IS NOT NULL
		BEGIN

			SET @IdEmps = ' ' + REPLACE(@IdEmps, ',', ' ') + ' ';
			
			INSERT INTO [dbo].[tEmpApp] (IdODept, IdOEmp, IdOApp)
			SELECT e.IdODept, e.IdEmployee, @IdApp
			FROM [dbo].[tblEmployee] e
			WHERE @IdEmps LIKE '% ' + CONVERT(nvarchar(100), e.IdEmployee) +' %'
			AND e.IdEmployee NOT IN (	SELECT EA.IdOEmp
										FROM dbo.tEmpApp ea
											INNER JOIN dbo.tAppointment a ON a.IdAppointment = ea.IdOApp
										WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = 2);

			DELETE FROM dbo.tEmpApp
			WHERE IdOApp = @IdApp AND IdODept = IdODept
				AND @IdEmps NOT LIKE '% ' + CONVERT(nvarchar(100), IdOEmp) + ' %'



			DECLARE Cur cursor FOR
			SELECT e.FullName
			FROM dbo.tEmpApp ea
				INNER JOIN dbo.tAppointment a ON a.IdAppointment = ea.IdOApp
				INNER JOIN dbo.tblEmployee e ON e.IdEmployee = ea.IdOEmp
			WHERE a.IdODoc = @IdDoc AND a.IdOTypeApp = 2

			OPEN Cur
			FETCH NEXT FROM Cur
			INTO @Emp

			WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @Emps = @Emps + @l + @Emp
					SET @l= ','
					FETCH NEXT FROM Cur
					INTO @Emp
				END
				CLOSE Cur
				DEALLOCATE Cur
				UPDATE dbo.tblDocIn
				SET Emps = @Emps
				WHERE IdDocIn = @IdDoc
		END

	ELSE IF @IdDepts IS NOT NULL
		BEGIN
			SET @IdDepts = ' ' + REPLACE(@IdDepts, ',', ' ') + ' ';

			INSERT INTO [dbo].[tEmpApp] (IdODept, IdOEmp, IdOApp)
			SELECT  e.IdODept, e.IdEmployee, @IdApp
			FROM [dbo].[ftEmpRole]('Maneger') e
			WHERE @IdDepts LIKE '% ' + CONVERT(nvarchar(100), e.IdODept) + ' %';
	END	
END
