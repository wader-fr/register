CREATE   PROCEDURE dbo.spTypeDocOutRibbon
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ROW_NUMBER() OVER (ORDER BY SortOrder, Id) - 1 AS Pos,
        Id,
        Label
    FROM
    (
        SELECT 0 AS SortOrder, 0 AS Id, N'<Все>' AS Label
        UNION ALL
        SELECT 1, -1, N'<ФГИС>'
        UNION ALL
        SELECT 2, dto.IdDocTypeOut, dto.DocTypeOut
        FROM dbo.tblDocTypeOut dto
    ) x;
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spTypeDocOutRibbon] TO PUBLIC
    AS [dbo];

