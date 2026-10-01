

CREATE PROCEDURE [dbo].[qGetRole] 

AS
BEGIN
declare @name_in_db SYSNAME = suser_name()

  SELECT
    usg.name
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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGetRole] TO PUBLIC
    AS [dbo];

