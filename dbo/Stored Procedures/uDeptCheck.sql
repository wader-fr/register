-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uDeptCheck]
	@IdDept int
	,@Cheсk bit
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE dbo.tblDept
	SET Act = @Cheсk
	WHERE IdDept = @IdDept

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uDeptCheck] TO [Admin]
    AS [dbo];

