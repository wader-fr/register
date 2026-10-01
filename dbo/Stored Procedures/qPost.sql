-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qPost]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT p.IdPost, p.Post
	FROM dbo.tblPost p
	ORDER BY p.Post

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPost] TO [Admin]
    AS [dbo];

