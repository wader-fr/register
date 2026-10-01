-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION ftAppointment 
(	 
	@IdEtap int
)
RETURNS TABLE 
AS
RETURN 
(
	
	SELECT * FROM dbo.tAppointment a WHERE a.IdOTypeApp = @IdEtap
)
