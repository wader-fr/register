
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnEmps]
(
	@IdDocIn bigint
)
RETURNS nvarchar(100)
AS
BEGIN

	DECLARE @ResultVar nvarchar(100)

		SELECT @ResultVar = a.IdsEmp
		FROM dbo.tAppointment a
		WHERE a.IdOTypeApp = 2
			AND a.IdODoc = @IdDocIn

	RETURN isnull(@ResultVar, ' ')

END
