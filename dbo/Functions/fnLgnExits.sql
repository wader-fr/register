
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnLgnExits]
(
	@lgn sysname
)
RETURNS bit
--With EXECUTE AS 'dbo'
AS
BEGIN
	DECLARE @ResultVar bit

	SELECT @ResultVar = COUNT(*)
	FROM sys.server_principals sp
	WHERE sp.name = @lgn

	RETURN @ResultVar

END
