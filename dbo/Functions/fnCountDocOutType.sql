-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountDocOutType]
(
	
)
RETURNS int
AS
BEGIN

	DECLARE @Result int


	SELECT @Result = COUNT(*) + 2
	FROM dbo.tblDocTypeOut

	RETURN @Result

END
