-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocTypeOutR]
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table(IdDocTypeOut int, DocTypeOut varchar(100))

	INSERT INTO @tbl
	VALUES (0, '<Все>'),(-1, '<FGIS>')



	INSERT INTO @tbl
	SELECT dto.IdDocTypeOut, dto.DocTypeOut
	FROM dbo.tblDocTypeOut dto
	ORDER BY dto.IdDocTypeOut

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocTypeOutR] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocTypeOutR] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocTypeOutR] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocTypeOutR] TO [Admin]
    AS [dbo];

