-- =============================================
-- Author:		Roman
-- Create date: 06.02.25
-- Description:	Список Id сотрудников по переданным кодам и по переданным кодам отделов
-- =============================================
CREATE FUNCTION [dbo].[fnIdEmpDeptList]
(
--	DECLARE
  @IdsEmp varchar(50) 
	,@IdsDept varchar(50) 
)
RETURNS varchar(MAX)
AS
BEGIN
	DECLARE @MaxRow int, @Row int = 1
	DECLARE @t table (RowNum int, IdEmp varchar(50))
	DECLARE @Result varchar(MAX)
	DECLARE @Emp varchar(50), @IdEmps varchar(150) = ' '

	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY e.IdEmployee), e.IdEmployee
	FROM [dbo].[tblEmployee] e
	WHERE @IdsEmp LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
		AND @IdsDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %'

	SET @MaxRow = @@ROWCOUNT

	WHILE @Row <= @MaxRow
		BEGIN
			SELECT @Emp = t.IdEmp FROM @t t WHERE t.RowNum = @Row
			SET @IdEmps = @IdEmps + @Emp + ' '
			SET @Row = @Row + 1
		END

		SET @Result = @IdEmps

	RETURN @Result
--	PRINT @Result

END
