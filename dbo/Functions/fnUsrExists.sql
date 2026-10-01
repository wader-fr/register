
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnUsrExists]
(
	@lgn sysname
)
RETURNS bit
AS
BEGIN

	DECLARE @Result bit

	SELECT @Result = COUNT(*)
	FROM sys.database_principals dp
	WHERE dp.name = @lgn

	RETURN @Result

END
