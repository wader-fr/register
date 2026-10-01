-- Batch submitted through debugger: SQLQuery2.sql|7|0|C:\Users\roman\AppData\Local\Temp\12\~vs1D9D.sql
-- =============================================
-- Author:		Roman
-- Create date: 21/02/2025
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[fnEmpForDept] 
(
--	DECLARE
	@IdsDept varchar(max), -- в каких отделах
	@IdsEmpN varchar(max),  -- Те, кого оставить
	@IdsEmp0 varchar(max) -- Те, кто сейчас
)
RETURNS  varchar(max)
AS
BEGIN
	DECLARE @pos int = 1, @maxpos int
	DECLARE @SubStr varchar(5)
	DECLARE @t table (pos int, IdEmp int)
	DECLARE @Result varchar(max) = NULL;
	
	WITH cte as(
				SELECT e.IdEmployee	
				FROM dbo.tblEmployee e
				WHERE @IdsEmp0 LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
					AND NOT @IdsDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %'
				UNION
				SELECT e.IdEmployee
				FROM dbo.tblEmployee e
				WHERE @IdsEmpN LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
					AND @IdsDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %'
	)

	INSERT INTO @t
	SELECT ROW_NUMBER() OVER(ORDER BY cte.IdEmployee) pos,  cte.IdEmployee FROM cte

	SET @maxpos = @@ROWCOUNT

	WHILE @pos <= @maxpos
		BEGIN
			SELECT @SubStr = t.IdEmp FROM @t t WHERE t.pos = @pos
			SET @Result = ISNULL(@Result, ' ') + @SubStr + ' '
			SET @pos = @pos + 1 
		END

--	PRINT @Result
	RETURN @Result

END
