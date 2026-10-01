-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptS]
	@Id int
AS
BEGIN
	SET NOCOUNT ON;


	SELECT d.IdDept
			,d.NameDept
			,d.sNameDept
			,d.IdOFilial
			,d.PIdDept
			,d.Act
			,d.TLC
	FROM dbo.tblDept d
	WHERE d.IdDept = @Id

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDeptS] TO [Admin]
    AS [dbo];

