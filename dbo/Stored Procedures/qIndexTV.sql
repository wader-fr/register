-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qIndexTV]
	--DECLARE
	@DocOut BIGINT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT i.IdIndex, 'Id' + CAST(i.IdIndex AS VARCHAR(20)) Id, i.NameIndex, CASE WHEN ixs.IdIndexes IS NOT NULL THEN -1 ELSE 0 END Cheked
	FROM dbo.tIndex i
		LEFT OUTER JOIN tIndexes ixs ON i.IdIndex = ixs.IdOIndex AND ixs.IdODocOut = @DocOut
	ORDER BY i.NameIndex

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qIndexTV] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qIndexTV] TO [Admin]
    AS [dbo];

