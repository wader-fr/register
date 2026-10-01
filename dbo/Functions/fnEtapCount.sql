-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnEtapCount]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int


	SELECT @Result = COUNT(*) + 1
	FROM dbo.tTypeAppointment ta

	-- Return the result of the function
	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEtapCount] TO PUBLIC
    AS [dbo];

