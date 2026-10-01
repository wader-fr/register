-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aIndexes]
	--DECLARE
	@IdIndex int
	,@IdDocOut bigint
	,@IdIndexes int OUT
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO tIndexes (IdOIndex, IdODocOut)
	VALUES (@IdIndex, @IdDocOut)

	SET @IdIndexes = @@identity

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aIndexes] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aIndexes] TO [Admin]
    AS [dbo];

