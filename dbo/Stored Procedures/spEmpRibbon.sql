CREATE   PROCEDURE [dbo].[spEmpRibbon]
    @IdDept INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @IdFil INT,
        @IdEmp INT,
        @EmpDept INT,
        @IsAdmin BIT = 0,
        @IsManager BIT = 0;

    if @IdDept = 0 set @IdDept = null

    -- текущий пользователь
    SELECT
        @IdFil = d.IdOFilial,
        @IdEmp = e.IdEmployee,
        @EmpDept = e.IdODept
    FROM dbo.tblEmployee e
    JOIN dbo.tblDept d ON d.IdDept = e.IdODept
    WHERE e.lgn = SYSTEM_USER;

    -- роли (лучше один раз)
    IF IS_MEMBER('db_owner') = 1 OR IS_MEMBER('Admin') = 1
        SET @IsAdmin = 1;
    ELSE IF IS_MEMBER('Maneger') = 1
        SET @IsManager = 1;

    -- базовый набор сотрудников
    CREATE TABLE #Base
    (
        IdEmployee INT,
        FullName NVARCHAR(255),
        IdOFilial INT,
        IdODept INT
    );

    INSERT INTO #Base
    SELECT
        e.IdEmployee,
        e.FullName,
        d.IdOFilial,
        e.IdODept
    FROM dbo.tblEmployee e
    JOIN dbo.tblDept d ON d.IdDept = e.IdODept
    WHERE e.Fired = 0;

    -- =========================
    -- ADMIN / OWNER
    -- =========================
    IF @IsAdmin = 1
    BEGIN
        SELECT 0 AS Pos, 0 AS Id, N'<Все>' AS Label

        UNION ALL

        SELECT
            ROW_NUMBER() OVER (ORDER BY b.IdEmployee),
            b.IdEmployee,
            b.FullName
        FROM #Base b
        WHERE
            (
                @IdDept IS NULL AND b.IdOFilial = @IdFil
            )
            OR
            (
                @IdDept IS NOT NULL AND b.IdODept = @IdDept
            );

        RETURN;
    END

    -- =========================
    -- MANAGER (только свой отдел)
    -- =========================
    IF @IsManager = 1
    BEGIN
        SELECT 0 AS Pos, 0 AS Id, N'<Все>' AS Label

        UNION ALL

        SELECT
            ROW_NUMBER() OVER (ORDER BY b.IdEmployee),
            b.IdEmployee,
            b.FullName
        FROM #Base b
        WHERE b.IdODept = @EmpDept;

        RETURN;
    END

    -- =========================
    -- OTHERS (только себя)
    -- =========================
    SELECT
        0 AS Pos,
        b.IdEmployee AS Id,
        b.FullName AS Label
    FROM #Base b
    WHERE b.IdEmployee = @IdEmp;

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spEmpRibbon] TO PUBLIC
    AS [dbo];

