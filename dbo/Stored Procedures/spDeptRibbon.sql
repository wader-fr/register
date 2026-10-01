CREATE PROCEDURE dbo.spDeptRibbon
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdDeptUser INT,
            @IsFull BIT = 0;

    -- текущий пользователь → его отдел
    SELECT TOP 1
        @IdDeptUser = e.IdODept
    FROM dbo.tblEmployee e
    WHERE e.lgn = SYSTEM_USER;

    -- роли доступа
    IF IS_MEMBER('db_owner') = 1
       OR IS_MEMBER('Admin') = 1
       OR IS_MEMBER('RegistrarB') = 1
       OR IS_MEMBER('RegistrarM') = 1
    BEGIN
        SET @IsFull = 1;
    END

    -- =========================
    -- РЕЗУЛЬТАТ
    -- =========================

    -- FULL ACCESS (с <Все>)
    IF @IsFull = 1
    BEGIN
        SELECT 0 AS Pos,
               0 AS IdDept,
               N'<Все>' AS Label

        UNION ALL

        SELECT
            ROW_NUMBER() OVER (ORDER BY d.IdDept),
            d.IdDept,
            d.sNameDept
        FROM dbo.tblDept d
        WHERE d.Act = 1;

        RETURN;
    END

    -- LIMITED ACCESS (БЕЗ <Все>)
    SELECT
        1 AS Pos,
        d.IdDept,
        d.sNameDept Label
    FROM dbo.tblDept d
    WHERE d.Act = 1
      AND d.IdDept = @IdDeptUser;

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spDeptRibbon] TO PUBLIC
    AS [dbo];

