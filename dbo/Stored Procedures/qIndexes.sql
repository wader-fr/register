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
