
CREATE PROCEDURE [dbo].[qGetRole] (@name_in_db SYSNAME)

AS
BEGIN

  SELECT
    usg.name
   --,dbo.fnRoleDescrypt(usg.name) AS RDescrypt
  FROM sys.sysusers AS usu
  LEFT OUTER JOIN sys.sysmembers AS mem
  INNER JOIN sys.sysusers AS usg
    ON mem.groupuid = usg.uid
    ON usu.uid = mem.memberuid

  WHERE (usu.islogin = 1)
  AND (usu.isaliased = 0)
  AND (usu.hasdbaccess = 1)
  AND (usg.issqlrole = 1)
  AND (usu.sid = SUSER_SID(@name_in_db))
  OR (usu.islogin = 1)
  AND (usu.isaliased = 0)
  AND (usu.hasdbaccess = 1)
  AND (usu.sid = SUSER_SID(@name_in_db))
  AND (usg.uid IS NULL)

END
  

