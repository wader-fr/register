-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountBudget]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblBudget b

	RETURN @Result

END
