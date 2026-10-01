-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qResigningDoc]
--	DECLARE
	@IdDocOut bigint = 222
	,@IdTypeDocOut int = 13
AS
BEGIN

	SET NOCOUNT ON;

	SELECT do.IdDocOut, do.NumDocOut Номер, CONVERT(char(10), do.DateDocOut, 104) Дата
	FROM dbo.tDocOut do
	WHERE do.aNumDocOut = @IdDocOut
			AND do.IdOTypeDocOut = @IdTypeDocOut
	ORDER BY do.DateDocOut DESC


END
