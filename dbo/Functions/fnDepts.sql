
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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDepts] TO [Admin]
    AS [dbo];

