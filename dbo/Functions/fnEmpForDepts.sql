-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnEmpForDepts]
(
	--DECLARE
	@IdsDept varchar(500),
	@IdsEmp varchar(500)
)
RETURNS  varchar(500)
AS
BEGIN
	DECLARE @t table (pos int, IdEmp int)
	DECLARE @SubStr varchar(10)
	DECLARE @pos int = 1, @MaxPos int
	DECLARE @Result as varchar(500)
	
	INSERT INTO @t
	SELECT ROW_NUMBER() OVER (ORDER BY e.IdEmployee) pos, e.IdEmployee 
	FROM dbo.tblEmployee e
	WHERE @IdsEmp LIKE '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
		AND @IdsDept LIKE '% ' + CONVERT(varchar(10), e.IdODept) + ' %'
	
	SET @MaxPos = @@ROWCOUNT
	
	WHILE @pos <= @MaxPos
		BEGIN
			SELECT @SubStr = t.IdEmp FROM @t t WHERE t.pos = @pos
			SET @Result = ISNULL(@Result, ' ') + @SubStr + ' '
			SET @pos = @pos + 1
		END
	RETURN @Result
	END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEmpForDepts] TO PUBLIC
    AS [dbo];

