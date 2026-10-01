-- =============================================
-- Author:		Roman
-- Create date: 27.02.2025
-- Description:	Объединение списков сотрудников
-- =============================================
CREATE FUNCTION [dbo].[fnEmpAdd]
(
	@Emp1 varchar(max),
	@Emp2 varchar(max)
)
RETURNS varchar(max)
AS
BEGIN
	
	DECLARE @t table (pos int, IdEmp int)
	DECLARE @pos int = 1, @maxpos int
	DECLARE @SubStr varchar(10)
	DECLARE @Result varchar(max);
	
	WITH cte as(
		SELECT e.IdEmployee
		FROM dbo.tblEmployee e
		WHERE @Emp1 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'

		UNION
		SELECT e.IdEmployee
		FROM dbo.tblEmployee e
		WHERE @Emp2 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
		)

	INSERT INTO @t
	SELECT DISTINCT ROW_NUMBER() OVER(ORDER BY t.IdEmployee) pos, t.IdEmployee FROM cte t

	SET @maxpos = @@ROWCOUNT

	WHILE @pos <= @maxpos
		BEGIN
			SELECT @SubStr = t.IdEmp FROM @t t WHERE t.pos = @pos
			SET @Result = ISNULL(@Result, ' ') + @SubStr + ' '
			SET @pos = @pos + 1
		END

	RETURN @Result

END
