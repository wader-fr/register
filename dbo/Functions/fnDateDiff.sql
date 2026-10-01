-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.fnDateDiff 
(
	@DateB datetime
	,@DateE datetime
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	-- Add the T-SQL statements to compute the return value here
	IF @DateB < @DateE

		SELECT @Result = COUNT(*)
		FROM dbo.tCldr c
		WHERE c.DateD BETWEEN @DateB AND @DateE

	ELSE
		SELECT @Result = -COUNT(*)
		FROM dbo.tCldr c
		WHERE c.DateD BETWEEN @DateE AND @DateB

	-- Return the result of the function
	RETURN @Result

END
