-- =============================================
-- Author:		Roman
-- Create date: 06.04.2025
-- Description:	Возвращает список отделов через запятую, по списку ид отделов
-- =============================================
CREATE FUNCTION [dbo].[fnDeptList] 
(
	-- Add the parameters for the function here
	@IdsDept varchar(50)
)
RETURNS varchar(100)
AS
BEGIN

	DECLARE @MaxRow int, @Row int = 1
	DECLARE @t table (RowNum int, SNameDept varchar(10))
	DECLARE @sDept varchar(10), @Depts varchar(100) = ''
	DECLARE @Result varchar(100)

-- Оптимизация списка отделов. Формат = " 1 2 12 "
	SET @IdsDept = RTRIM(LTRIM(@IdsDept))
	SET @IdsDept = REPLACE(@IdsDept, ',',' ')
	SET @IdsDept = REPLACE(@IdsDept, ';',' ')

	WHILE CHARINDEX(@IdsDept,'  ', 1)>0
		SET @IdsDept = REPLACE(@IdsDept, '  ',' ')
	
	SET @IdsDept = ' ' + @IdsDept + ' '

--Заполняем таблицу сокращениями названий отделов, отфильтрованными по списку ид. Первый столбец - порядковый номер строки
	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY d.IdDept), d.sNameDept
	FROM dbo.tblDept d
	WHERE @IdsDept LIKE '% ' + CONVERT(VARCHAR(50), d.IdDept) + ' %'

--задаем количество строк для перебора в цикле
	SET @MaxRow = @@ROWCOUNT

--Перебираем список по порядку (альтернатива курсору)
	WHILE @Row <= @MaxRow
	BEGIN
		--Выборка строк по порядковому номеру
		SELECT @sDept = t.SNameDept FROM @t t WHERE t.RowNum = @Row
		--Собираем в преременную через пробел
		SET @Depts = @Depts + @sDept + ' '
		--добавляем счетчик
		SET @Row = @Row + 1
	END
--удаляем лишний пробел
	SET @Depts = RTRIM(@Depts)
--Результат: заменяем пробелы запятыми
	SET @Result = REPLACE(@Depts, ' ', ', ')

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDeptList] TO PUBLIC
    AS [dbo];

