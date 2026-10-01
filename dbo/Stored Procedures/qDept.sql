
CREATE PROCEDURE [dbo].[qDept]
	AS
BEGIN
	SET NOCOUNT ON;

	SELECT d.IdDept, d.NameDept, d.sNameDept, d.PIdDept, d.Act, d.TLC FROM dbo.tblDept d

END
