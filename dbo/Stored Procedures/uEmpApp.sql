
CREATE PROCEDURE [dbo].[uEmpApp]
--DECLARE
	@Ids nvarchar(100) = '2,3'
	,@IdDoc bigint = 60008
	,@IdEmp int = 54

AS
BEGIN
	DECLARE @IdApp bigint
		--,@SQL nvarchar(max)


	SET @Ids = ' ' + REPLACE(@Ids, ',', ' ') + ' ' 

	SELECT @IdApp = a.IdAppointment FROM [dbo].[tAppointment] a WHERE a.IdODoc = @IdDoc;

	IF @IdApp IS NULL
		BEGIN
			INSERT INTO [dbo].[tAppointment] (IdODoc, IdOEmp, IdOTypeApp, DateExec)
			VALUES (@IdDoc, @IdEmp, 1, GETDATE());
			SET @IdApp = @@IDENTITY;
		END

	ELSE

	DELETE FROM tEmpApp
	WHERE (IdOApp = @IdApp)


			/*INSERT INTO [dbo].[tEmpApp] (IdODept, IdOEmp, IdOApp)
			SELECT  e.IdODept, e.IdEmployee, @IdApp
			FROM [dbo].[ftEmpRole]('Maneger') e
			WHERE @Ids LIKE '% ' + CONVERT(nvarchar(100), e.IdODept) + ' %'*/

	INSERT INTO [dbo].[tEmpApp] (IdODept, IdOEmp, IdOApp)
	SELECT e.IdODept, IdEmployee, @IdApp
	FROM [dbo].[tblEmployee] e
	WHERE @Ids LIKE '% ' + CONVERT(nvarchar(100), e.IdODept) + ' %'
		AND  e.Roles LIKE '%Maneger%'

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uEmpApp] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uEmpApp] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uEmpApp] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uEmpApp] TO [Admin]
    AS [dbo];

