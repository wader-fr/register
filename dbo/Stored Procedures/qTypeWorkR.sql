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
