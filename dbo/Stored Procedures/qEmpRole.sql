
CREATE PROCEDURE [dbo].[qEmpRole]
--	DECLARE
		@Role SYSNAME

AS
BEGIN

	SELECT e.*
	FROM sys.sysusers AS usu
		LEFT OUTER JOIN sys.sysmembers AS mem
		INNER JOIN sys.sysusers AS usg
			ON mem.groupuid = usg.uid
			ON usu.uid = mem.memberuid
		LEFT OUTER JOIN dbo.tblEmployee e ON e.lgn = usu.name
	WHERE (usu.islogin = 1)
		AND (usu.isaliased = 0)
		AND (usu.hasdbaccess = 1)
		AND (usg.issqlrole = 1)
		AND (usg.name = @Role)
		OR (usu.islogin = 1)
		AND (usu.isaliased = 0)
		AND (usu.hasdbaccess = 1)
		AND (usg.name = @Role)
		AND (usg.uid IS NULL)
END
  

