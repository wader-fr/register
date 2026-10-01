-- =============================================
-- Author:		Roman
-- Create date: 06.02.25
-- Description:	Список имен сотрудников через запятую, по переданным кодам
-- =============================================
CREATE FUNCTION fnEmpList
(
	@IdsEmp varchar(50)
	--,@IdsDept varchar(50)
)
RETURNS varchar(MAX)
AS
BEGIN
	DECLARE @MaxRow int, @Row int = 1
	DECLARE @t table (RowNum int, FullName varchar(50))
	DECLARE @Result varchar(MAX)
	DECLARE @Emp varchar(50), @Emps varchar(Max) = ''

	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY e.IdEmployee), e.FullName
	FROM [dbo].[tblEmployee] e
	WHERE @IdsEmp LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'

	SET @MaxRow = @@ROWCOUNT

	WHILE @Row <= @MaxRow
		BEGIN
			SELECT @Emp = t.FullName FROM @t t WHERE t.RowNum = @Row
			SET @Emps = @Emps + @Emp + '  '
			SET @Row = @Row + 1
		END

		SET @Emps = RTRIM(@Emps)
		SET @Result = REPLACE(@Emps, '  ', ', ')

	RETURN @Result

END
