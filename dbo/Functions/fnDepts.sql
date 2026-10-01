
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnDepts]
(
	@IdDocIn bigint
)
RETURNS nvarchar(100)
AS
BEGIN

	DECLARE @ResultVar nvarchar(100)

		SELECT @ResultVar = a.IdsDept
		FROM dbo.tAppointment a
		WHERE a.IdOTypeApp = 1
			AND a.IdODoc = @IdDocIn

	RETURN isnull(@ResultVar, ' ')

END
