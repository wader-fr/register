-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountDocInType]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int


	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblDocType
	WHERE Act = 1


	RETURN @Result

END
