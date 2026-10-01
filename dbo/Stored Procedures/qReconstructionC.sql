-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qReconstructionC]
	--DECLARE
	@IdExp varchar(3)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @IdExpS varchar(6)
	SET @IdExpS = '%.' + @IdExp + '.%'

	SELECT r.IDReconstruction, r.Reconstruction
	FROM dbo.tblReconstruction r
	WHERE r.[Exp] LIKE @IdExpS

END
