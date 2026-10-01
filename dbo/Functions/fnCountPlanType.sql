CREATE FUNCTION [dbo].fnCountPlanType
(
)
RETURNS INT
AS
BEGIN

	DECLARE @Result int

	select @Result = count(*) + 1
	from dbo.tSMeasType

	RETURN @Result
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnCountPlanType] TO PUBLIC
    AS [dbo];

