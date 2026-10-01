-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qContragentC]
AS
BEGIN

	SET NOCOUNT ON;


	SELECT c.IdContragent, c.fName
	FROM dbo.tblContragent c
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qContragentC] TO PUBLIC
    AS [dbo];

