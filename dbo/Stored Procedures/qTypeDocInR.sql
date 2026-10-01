-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeDocInR] 
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table(IdDocType int, DocType varchar(75))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT dt.IdDocType, dt.DocType
	FROM dbo.tblDocType dt
	WHERE dt.Act = 1
	ORDER BY dt.Ordr

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocInR] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocInR] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocInR] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeDocInR] TO [Admin]
    AS [dbo];

