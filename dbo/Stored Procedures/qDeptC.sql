-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptC]
--	DECLARE
	@Act bit
AS
BEGIN
	SET NOCOUNT ON;
	declare @IdFil int = 0

	select @IdFil = d.IdOFilial
	from dbo.tblEmployee e 
		inner join dbo.tblDept d on d.IdDept = e.IdODept
	where e.lgn = SYSTEM_USER

	SELECT d.IdDept, d.sNameDept
	FROM dbo.tblDept d
	WHERE (d.IdOFilial = @IdFil OR @IdFil = 0) AND d.Act >= isnull(@Act, 1)

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDeptC] TO PUBLIC
    AS [dbo];

