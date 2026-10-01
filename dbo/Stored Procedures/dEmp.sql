-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[dEmp]
	@IdEmp int
AS
BEGIN

	SET NOCOUNT ON;

		DELETE FROM dbo.tblEmployee
		WHERE IdEmployee = @IdEmp

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[dEmp] TO [Admin]
    AS [dbo];

