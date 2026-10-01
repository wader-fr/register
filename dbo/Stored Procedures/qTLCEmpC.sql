-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTLCEmpC]
	--DECLARE
	@Attestat nvarchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT te.IdTLCEmp, te.TLCLastName + ' '  + te.TLCFirstName + ' ' + te.TLCPatronimic TLCName
	FROM dbo.tTLCEmp te
	WHERE te.AttestatTLC = @Attestat

END
