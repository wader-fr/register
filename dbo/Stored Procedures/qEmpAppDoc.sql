-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEmpAppDoc]
--DECLARE
	@IdDoc bigint = 74051
AS
BEGIN

	SET NOCOUNT ON;

	
	SELECT CONVERT(varchar(10), a.DateApp, 104) +  ', ' +  ta.TypeApp +': ' + a.Depts + ', ' +  ISNULL(a.Emps, '') [Event]
	FROM [dbo].[tAppointment] a
	LEFT OUTER JOIN [dbo].[tTypeAppointment] ta on ta.IdTypeAppointment = a.IdOTypeApp
	WHERE a.IdODoc = @IdDoc;

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppDoc] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppDoc] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppDoc] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qEmpAppDoc] TO [Admin]
    AS [dbo];

