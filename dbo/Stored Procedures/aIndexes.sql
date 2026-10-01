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
