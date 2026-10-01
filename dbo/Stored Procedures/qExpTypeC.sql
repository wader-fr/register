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
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qExpTypeC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qExpTypeC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qExpTypeC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qExpTypeC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qExpTypeC] TO [Admin]
    AS [dbo];

