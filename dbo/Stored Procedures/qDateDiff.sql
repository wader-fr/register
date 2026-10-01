

CREATE PROCEDURE [dbo].[qDateDiff]
	--DECLARE 
		@DateB datetime
		, @DateE datetime
AS
	IF @DateB < @DateE

		SELECT COUNT(*) dd
		FROM dbo.tCldr c
		WHERE c.DateD BETWEEN @DateB AND @DateE

	ELSE
		SELECT -COUNT(*) dd
		FROM dbo.tCldr c
		WHERE c.DateD BETWEEN @DateE AND @DateB
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDateDiff] TO PUBLIC
    AS [dbo];

