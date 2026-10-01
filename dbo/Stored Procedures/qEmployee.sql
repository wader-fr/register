-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmployee]
	@IdDept int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT e.IdEmployee
			,e.LastName
			,e.FirstName
			,e.Patronimic
			,e.IdODept
			,e.Post
			,e.lgn
			,e.Fired
			,e.Roles
	FROM dbo.tblEmployee e
	WHERE e.IdODept = @IdDept
	ORDER BY e.LastName

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmployee] TO [Admin]
    AS [dbo];

