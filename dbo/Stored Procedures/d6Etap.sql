


-- =============================================
-- Author:		Roman
-- Create date: 27.02.2025
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[d6Etap]
--DECLARE
	@IdDoc bigint = 74051
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @IdEtap int = 6
	
	DELETE FROM dbo.tAppointment
	WHERE IdODoc = @IdDoc AND IdOTypeApp = @IdEtap

	update dbo.tblDocIn
	set DateEnd = null
	where IdDocIn = @IdDoc
	
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[d6Etap] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[d6Etap] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[d6Etap] TO [Admin]
    AS [dbo];

