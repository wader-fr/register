-- =============================================
-- Author:		Roman
-- Create date: 19/02/2025
-- Description:	Объединение списков отделов
-- =============================================
CREATE FUNCTION [dbo].[fnDeptAdd] 
(
	--	DECLARE
	@Depts1 varchar(500)
	,@Depts2 varchar(500)
)
RETURNS varchar(50)
AS
BEGIN

	DECLARE @t table (pos int, IdDept int)
	DECLARE @Pos int = 1, @maxpos int
	DECLARE @SubStr varchar(10)
	DECLARE @Result varchar(50);
	
	WITH CTE AS(
		SELECT d.IdDept
		FROM dbo.tblDept d
		WHERE @Depts1 LIKE '% ' + CONVERT(varchar(10), d.IdDept) + ' %'


		UNION SELECT d.IdDept
		FROM dbo.tblDept d
		WHERE @Depts2 LIKE '% ' + CONVERT(varchar(10), d.IdDept) + ' %'
		)

	INSERT INTO @t
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY CTE.IdDept) pos, CTE.IdDept FROM CTE

	--SET @maxpos =  @@ROWCOUNT
	SELECT @maxpos = COUNT(*) FROM @t
	WHILE @Pos <= @maxpos
		BEGIN
			SELECT @SubStr = t.IdDept FROM @t t WHERE t.pos = @Pos
			SET @Result = ISNULL(@Result,' ') + @SubStr + ' '
			SET @Pos = @Pos + 1
		END
		--PRINT @Result + ' ' 
	RETURN @Result

END
