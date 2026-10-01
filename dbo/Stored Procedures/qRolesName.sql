
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qRolesName]
	--DECLARE
	@NameInDB sysname -- = 'Фатеев'
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT r.principal_id, r.name,ISNULL((
			SELECT 1
			FROM sys.database_role_members m
					INNER JOIN sys.database_principals u ON u.principal_id = m.member_principal_id
			WHERE u.name = @NameInDB AND m.role_principal_id = r.principal_id),0) u
	FROM sys.database_principals r
	WHERE r.is_fixed_role=0 AND r.type = 'r' AND r.name <> 'Public'
		
	
/*
	SELECT r.principal_id, r.name, ISNULL((SELECT 1 FROM sys.database_principals u WHERE u.name = @NameInDB AND u.principal_id = m.member_principal_id),0) u
	FROM sys.database_principals r
			LEFT OUTER JOIN sys.database_role_members m ON m.role_principal_id = r.principal_id
	WHERE r.is_fixed_role=0 AND r.type = 'r' AND r.name <> 'Public'
*/
END
