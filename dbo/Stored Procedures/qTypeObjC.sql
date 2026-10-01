-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeObjC]
--	DECLARE
	@IdExp varchar(3)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @IdExpS varchar(6)
	SET @IdExpS = '%.' + @IdExp + '.%'

	SELECT o.IdTypeObj
			,ISNULL(o.codeObj,o.TypeObj) TypeO
			,ISNULL(o.codeObj + ' ' + o.TypeObj, o.TypeObj) TypeOS

	FROM dbo.tblTypeObj o
	WHERE o.[Exp] LIKE  @IdExpS

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjC] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjC] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjC] TO [Admin]
    AS [dbo];

