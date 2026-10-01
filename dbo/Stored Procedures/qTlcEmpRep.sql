-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTlcEmpRep]
	--DECLARE
	@IdDocOut Int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT e.TLCFirstName, e.TLCFirstName, e.TLCPatronimic
	FROM dbo.tTLCDocOut AS tlc INNER JOIN
		dbo.tTLCEmp AS e ON e.IdTLCEmp = tlc.IdOEmp
	WHERE tlc.IdODocOut = @IdDocOut

END
