-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qExpTypeC]
--	DECLARE
	@IdDoc varchar(2)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @IdDocS varchar(6)

	SET @IdDocS = '%.' + @IdDoc + '.%'

	SELECT e.IdExpType, e.ExpType
	FROM dbo.tblExp e
	WHERE e.TypeDoc LIKE @IdDocS

END
