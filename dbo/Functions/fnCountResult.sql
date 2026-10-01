-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountResult]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblResult

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnCountResult] TO PUBLIC
    AS [dbo];

