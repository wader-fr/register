CREATE FUNCTION dbo.fnGetCurrentEmployee()
RETURNS int
AS
BEGIN
    RETURN
    (
        SELECT IdEmployee
        FROM dbo.tblEmployee
        WHERE lgn = SYSTEM_USER
    );
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnGetCurrentEmployee] TO PUBLIC
    AS [dbo];

