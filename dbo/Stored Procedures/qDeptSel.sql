-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptSel] 
--	DECLARE
	@Ids VARCHAR(255) = NULL
AS
BEGIN

  SET NOCOUNT ON;

  DECLARE @SQL VARCHAR(MAX)

	SELECT  d.IdDept, d.sNameDept, CASE WHEN dd.IdDept IS NULL THEN 0 ELSE 1 END sel
	FROM dbo.tblDept d
	LEFT OUTER JOIN (SELECT d.IdDept
					FROM dbo.tblDept d
					WHERE @ids LIKE '% ' + CONVERT(varchar(5), d.IdDept) + ' %') dd ON dd.IdDept = d.IdDept
					WHERE d.Act = 1

	/*SELECT d.IdDept, d.sNameDept, NULL sel
	FROM dbo.tblDept d
	WHERE d.Act = 1



  IF @Ids IS NULL
	
    SET @SQL = 'SELECT d.IdDept, d.sNameDept, 0 sel
	FROM dbo.tblDept d
	WHERE d.Act = 1'
  ELSE
    SET @SQL = 'SELECT d.IdDept, d.sNameDept, ISNULL((SELECT 1
		FROM dbo.tblDept AS dd
		WHERE dd.IdDept IN(' + @Ids + ') AND dd.IdDept = d.IdDept), 0) AS sel
		FROM dbo.tblDept AS d
		WHERE d.Act = 1
		ORDER BY sel DESC'

  EXEC (@SQL)
*/
END
  
