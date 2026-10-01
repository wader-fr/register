
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aLgn]
--	DECLARE
	@lgn sysname 
	,@pass nvarchar(15)
AS
BEGIN

	SET NOCOUNT ON;

	EXEC('CREATE LOGIN ' + @lgn + ' WITH PASSWORD = N''' + @pass + ''', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF')
	EXEC('CREATE USER ' + @lgn + ' FOR LOGIN ' + @lgn)

END
