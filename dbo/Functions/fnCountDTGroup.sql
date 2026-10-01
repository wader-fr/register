-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountDTGroup]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblGroupDocType gdt
	
	RETURN  @Result

END
