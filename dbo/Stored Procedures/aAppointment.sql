CREATE PROCEDURE [dbo].[aAppointment]
	@IdDoc bigint
	,@IdTypeApp int = 1
	,@DateExec datetime = GetDate
	,@IdEmp int
	,@IdApp bigint out
AS
BEGIN
	
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT * FROM [dbo].[tAppointment] WHERE [IdODoc] = @IdDoc AND [IdOTypeApp] = @IdTypeApp)
		SELECT @IdApp = A.IdAppointment  FROM [dbo].[tAppointment] A WHERE [IdODoc] = @IdDoc AND [IdOTypeApp] = @IdTypeApp
	ELSE
		BEGIN
			INSERT INTO [dbo].[tAppointment] ([IdODoc], [IdOTypeApp], [DateExec], [IdOEmp])
			VALUES (@IdDoc, @IdTypeApp, @DateExec, @IdEmp)

			SET @IdApp = @@IDENTITY
		END

END
