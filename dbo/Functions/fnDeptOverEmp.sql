-- =============================================
-- Author:		Roman
-- Create date: 21.02.2025
-- Description:	Возвращает перечисление кодов отделов по кодам сотрудников
-- =============================================
CREATE FUNCTION [dbo].[fnDeptOverEmp] 
(
--	DECLARE
	@IdsEmp varchar(max) = ' '
)
RETURNS varchar(max)
AS
BEGIN
	DECLARE @t table(Pos int, IdDept int)
	DECLARE @SubStr varchar(10)
	DECLARE @pos int = 1, @maxpos int
	DECLARE @Result varchar(max) = NULL;
	
	WITH cte AS(
	SELECT DISTINCT e.IdODept FROM dbo.tblEmployee e WHERE @IdsEmp LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %')

	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY cte.IdODept) pos, * FROM cte

	SET @maxpos = @@ROWCOUNT

	WHILE @pos <= @maxpos
		BEGIN
			SELECT @SubStr = t.IdDept FROM @t t WHERE t.Pos = @pos
			SET @Result = ISNULL(@Result, ' ') + @SubStr + ' '
			SET @pos = @pos + 1
		END
		--SET @Result = ' ' + @Result
	RETURN ISNULL(@Result, '%')
--	Print @Result 
END
