-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[adIndexes]
	--DECLARE
	@IdDocOut bigint
	,@Index nvarchar(MAX)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @SQLString nvarchar(max)
	,@ParmDefinition nvarchar(500);

	IF @Index = '' 
		SET @Index = N'0';

	SET @SQLString = N'INSERT INTO tIndexes (IdOIndex, IdODocOut)
						SELECT i.IdIndex, @IdDocOut
						FROM tIndex i 
						WHERE i.IdIndex IN (' + @Index + ')
						AND i.IdIndex NOT IN (SELECT ix.IdOIndex FROM dbo.tIndexes ix WHERE ix.IdODocOut = @IdDocOut)';

	SET @ParmDefinition = N'@IdDocOut nvarchar(max)';

	EXEC sys.sp_executesql @SQLString, @ParmDefinition, @IdDocOut = @IdDocOut;


	 SET @SQLString = N'DELETE
						FROM tIndexes
						WHERE IdODocOut = @IdDocOut AND IdOIndex NOT IN (' + @Index + ')';

	SET @ParmDefinition = N'@IdDocOut nvarchar(max)';

	EXEC sys.sp_executesql @SQLString, @ParmDefinition, @IdDocOut = @IdDocOut;

END
