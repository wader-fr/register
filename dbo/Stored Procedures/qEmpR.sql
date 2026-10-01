-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpR]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @tbl table (IdEmp int, Emp varchar(100))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT e.IdEmployee, dbo.fnInitial( e.LastName + ' ' + e.FirstName + ' ' + e.Patronimic) emp
	FROM dbo.tblEmployee e
		INNER JOIN dbo.tblDept d ON d.IdDept = e.IdODept
	WHERE d.Act = 1
	ORDER BY e.LastName

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpR] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpR] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpR] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpR] TO [Admin]
    AS [dbo];

