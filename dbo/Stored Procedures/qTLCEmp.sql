-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTLCEmp]
	--DECLARE
	@Attestat nvarchar(20)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT te.IdTLCEmp, te.AttestatTLC, te.TLCLastName, te.TLCFirstName, te.TLCPatronimic
	FROM dbo.tTLCEmp te
	WHERE te.AttestatTLC = @Attestat

END
