-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[qObjectList] 
	@IdDocIn int
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT o.IdObject, o.NameObject, o.pAddress, o.IdODocIn, o.IdODept, o.IdOEmp, o.DateCont, o.DateEnd
	FROM dbo.tblObject o
	WHERE o.IdODocIn = @IdDocIn

END
