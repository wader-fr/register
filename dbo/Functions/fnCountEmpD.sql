-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountEmpD](@IdDept int = NULL)
RETURNS int
AS
BEGIN
	 
	DECLARE @Result int

	IF @IdDept = 0 SET @IdDept = NULL

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblEmployee e
		INNER JOIN dbo.tblDept d ON d.IdDept = e.IdODept
	WHERE d.Act = 1 AND e.Fired = 0 AND e.IdODept = ISNULL(@IdDept, e.IdODept)

	RETURN @Result

END
