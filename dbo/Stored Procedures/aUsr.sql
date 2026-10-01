
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aUsr]
--	DECLARE
	@lgn sysname 
AS
BEGIN

	SET NOCOUNT ON;

	EXEC('CREATE USER ' + @lgn + ' FOR LOGIN ' + @lgn)

END
