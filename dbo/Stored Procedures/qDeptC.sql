-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptC]
--	DECLARE
	@Act bit
	,@IdFil int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT d.IdDept, d.sNameDept
	FROM dbo.tblDept d
	WHERE (d.IdOFilial = @IdFil OR @IdFil = 0) AND d.Act >= @Act

END
