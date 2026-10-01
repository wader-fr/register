
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uRole]
--	DECLARE
	@Role sysname
	,@lgn sysname
	,@Cange bit
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @SQL nvarchar(4000)

	IF @Cange = 1
		EXEC sp_addrolemember @Role,  @lgn
	ELSE
		EXEC sp_droprolemember @Role,  @lgn

END

