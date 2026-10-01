CREATE FUNCTION [dbo].[fnGetNumAttach]
(
	@IdDocIn bigint
)
RETURNS int
AS
BEGIN
	
	DECLARE @Result int

	SELECT @Result = ISNULL(MAX(a.NumAttach), 0) + 1 FROM dbo.tAttach a WHERE a.IdODocIn=@IdDocIn

	RETURN @Result

END
