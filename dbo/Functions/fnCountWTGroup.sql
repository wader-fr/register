-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountWTGroup]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblGroupWorkType wdt
	
	RETURN  @Result

END
