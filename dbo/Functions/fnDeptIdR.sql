CREATE FUNCTION dbo.fnDeptIdR
(
    @Pos int
)
RETURNS int
AS
BEGIN
    DECLARE @Result int;
    DECLARE @IdFil int;

    DECLARE @tbl TABLE
    (
        pos int,
        IdDept int
    );

    SELECT @IdFil = d.IdOFilial
    FROM dbo.tblEmployee e
        INNER JOIN dbo.tblDept d
            ON d.IdDept = e.IdODept
    WHERE e.lgn = SYSTEM_USER;

    INSERT INTO @tbl
    VALUES (0, 0);

    INSERT INTO @tbl
    SELECT
        ROW_NUMBER() OVER (ORDER BY d.IdDept),
        d.IdDept
    FROM dbo.tblDept d
    WHERE d.Act = 1
      AND (
            @IdFil IS NULL
            OR d.IdOFilial = @IdFil
          );

    SELECT @Result = IdDept
    FROM @tbl
    WHERE pos = @Pos;

    RETURN @Result;
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnDeptIdR] TO PUBLIC
    AS [dbo];

