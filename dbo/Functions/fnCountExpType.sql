-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountExpType]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = count(*) + 1
	FROM dbo.tblExp

	RETURN @Result

END
