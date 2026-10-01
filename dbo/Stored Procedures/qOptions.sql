-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qOptions]	 
AS
BEGIN

	SET NOCOUNT ON;

	SELECT o.Name_Option, o.Optn
	FROM dbo.tblOption o

END
