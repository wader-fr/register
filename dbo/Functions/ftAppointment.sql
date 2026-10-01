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
GO
GRANT UPDATE
    ON OBJECT::[dbo].[ftAppointment] TO [Maneger]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ftAppointment] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ftAppointment] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ftAppointment] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ftAppointment] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ftAppointment] TO [Admin]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ftAppointment] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ftAppointment] TO [Maneger]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ftAppointment] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ftAppointment] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ftAppointment] TO [Maneger]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ftAppointment] TO [Expert]
    AS [dbo];

