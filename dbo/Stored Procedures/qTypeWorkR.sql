-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeWorkR] 
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table (IdWorkType int, WorkType varchar(100))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT wt.IdWorkType, wt.WorkType + ' (' + s.NameService + ')'
	FROM dbo.tblWorkType wt
			INNER JOIN dbo.tblService s ON s.IdService = wt.IdOService

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeWorkR] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeWorkR] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeWorkR] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeWorkR] TO [Admin]
    AS [dbo];

