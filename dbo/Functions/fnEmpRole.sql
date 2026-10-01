
CREATE FUNCTION [dbo].[fnEmpRole] 
(
@IdEmp int
)
RETURNS nvarchar(500)
AS 
BEGIN
DECLARE @cons nvarchar(500) = '' , @role nvarchar(15)
DECLARE
@name_in_db SYSNAME 

	SELECT @name_in_db = e.lgn FROM dbo.tblEmployee e WHERE e.IdEmployee = @IdEmp


DECLARE CUR cursor FOR
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

  OPEN CUR

  FETCH NEXT FROM CUR INTO @Role

  WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @cons = @cons + ' ' + @role
		FETCH NEXT FROM CUR INTO @Role

	END
	close cur
	deallocate cur 
	
	RETURN @cons

END
  

