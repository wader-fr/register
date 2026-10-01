-- =============================================
-- Author:		Roman
-- Create date: 06.02.2025
-- Description:	Принимает 2 переченя ИД отделов в строку и возвращает общие ИД
-- =============================================
CREATE FUNCTION [dbo].[fnDeptIntersection] 
(
--	DECLARE
	@Depts1 varchar(50) = ' 3 10 12 ' 
	,@Depts2 varchar(50) = ' 3 10 12 '
)
RETURNS varchar(50)
AS
BEGIN
	DECLARE @SubStr Varchar(10) = ''		--Промежуточный результат
	DECLARE @pos int = 1					--Счётчик для циклов
	DECLARE @maxpos int						--Количество циклов
	DECLARE @Result varchar(50)= NULL

	DECLARE @t table (RowNum int, IdDept int)

	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY t1.IdDept), t1.IdDept 
	FROM (SELECT d.IdDept FROM dbo.tblDept d WHERE @Depts1 LIKE '% ' + CONVERT(nvarchar(10), d.IdDept)  + ' %') t1
		JOIN
		(SELECT d.IdDept FROM dbo.tblDept d WHERE @Depts2 LIKE '% ' + CONVERT(nvarchar(10), d.IdDept)  + ' %') t2
		ON t1.IdDept = t2.IdDept

	SELECT @maxpos = COUNT(*) FROM @t
	
	
	WHILE @pos <= @maxpos
		BEGIN
			SELECT @SubStr = t.IdDept FROM @t t WHERE t.RowNum = @pos
			SET @Result = ISNULL(@Result, ' ') + @SubStr + ' '
			SET @pos = @pos + 1
		END

	--SELECT @Result
	RETURN @Result
END
