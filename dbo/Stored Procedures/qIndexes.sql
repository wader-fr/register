-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qIndexes]
	--DECLARE
	@IdDocOut BIGINT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT iss.IdIndexes, iss.IdOIndex, i.NameIndex,  iss.IdODocOut
	FROM dbo.tIndexes iss
		LEFT OUTER JOIN tIndex i ON i.IdIndex = iss.IdOIndex
	WHERE iss.IdODocOut = @IdDocOut
	END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qIndexes] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qIndexes] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qIndexes] TO [Admin]
    AS [dbo];

