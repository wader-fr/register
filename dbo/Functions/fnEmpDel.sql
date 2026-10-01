CREATE FUNCTION [dbo].[fnEmpDel]
(
--DECLARE
	@IdsDept varchar(max) = ' 15 ',
	@IdsEmp1 varchar(4000) = ' 48 50 191 ',
	@IdsEmp2 varchar(4000) = ' 48 191 '
)
RETURNS varchar(500)	
AS
BEGIN
	
	DECLARE @t table (pos int, IdEmp int)
	DECLARE @Substr varchar(15)
	DECLARE @pos int= 1, @maxpos int
	DECLARE @Result varchar(500);
	
	WITH cte as(
	SELECT e.IdEmployee
	FROM dbo.tblEmployee e
	WHERE @IdsEmp1 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %' AND @IdsDept NOT LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %' --e.IdODept <> @IdDept
	
	UNION
	SELECT e.IdEmployee
	FROM dbo.tblEmployee e
	WHERE @IdsEmp1 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %' AND @IdsEmp2 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'  AND  @IdsDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %' --e.IdODept = @IdDept
	)
	INSERT INTO @t
	SELECT ROW_NUMBER() OVER(ORDER BY IdEmployee) pos,  * FROM cte
	
	SET @maxpos =@@ROWCOUNT
	WHILE @pos <= @maxpos
		BEGIN
			SELECT @Substr = IdEmp FROM @t WHERE pos = @pos
			SET @Result = ISNULL(@Result, ' ')+ @Substr + ' '
			
			SET @pos = @pos + 1
		END
--		PRINT @Result
		RETURN @Result
END
