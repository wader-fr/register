-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountEmp]
(
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblEmployee e
	INNER JOIN dbo.tblDept d ON d.IdDept = e.IdODept
	WHERE d.Act = 1

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnCountEmp] TO PUBLIC
    AS [dbo];

