-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qEtapList]
--DECLARE 
	@IdDoc bigint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT a.IdAppointment, a.IdODept, ta.TypeApp, a.Emps, a.Depts
	FROM dbo.tAppointment a
		INNER JOIN dbo.tTypeAppointment ta ON ta.IdTypeAppointment = a.IdOTypeApp
	WHERE a.IdODoc = @IdDoc


END
