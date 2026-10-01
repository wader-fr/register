-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountDept]
(
	@IdFilial int
)
RETURNS int
AS
BEGIN
	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblDept d
	WHERE (d.IdOFilial = ISNULL(@IdFilial, d.IdOFilial) OR @IdFilial = 0) AND d.Act = 1

	RETURN @Result

END
