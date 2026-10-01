-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpDR]
--DECLARE
	@IdDept int = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @tbl table (IdEmp int, Emp varchar(100))

	IF @IdDept = 0 SET @IdDept = NULL

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT e.IdEmployee, e.FullName
	FROM dbo.tblEmployee e
		INNER JOIN dbo.tblDept d ON d.IdDept = e.IdODept
	WHERE d.Act = 1 AND e.Fired = 0 AND e.IdODept = ISNULL(@IdDept,e.IdODept) AND d.Act = 1
	ORDER BY e.LastName

	SELECT * FROM @tbl

END
