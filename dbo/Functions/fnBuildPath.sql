
CREATE FUNCTION [dbo].[fnBuildPath] (
--  declare
  @Part1 NVARCHAR(4000) = null,
    @Part2 NVARCHAR(4000)= null,
    @Part3 NVARCHAR(4000) = null,
    @Part4 NVARCHAR(4000) = null
)
RETURNS NVARCHAR(4000)
AS
BEGIN
    DECLARE @Result NVARCHAR(4000);

    -- Удаляем завершающие/начальные слеши и собираем путь
    SET @Result = RTRIM(LTRIM(@Part1));
    IF RIGHT(@Result, 1) != '\' SET @Result = @Result + '\';

    SET @Result = @Result + RTRIM(LTRIM(@Part2));
    IF @Part3 IS NOT NULL
    BEGIN
        IF RIGHT(@Result, 1) != '\' SET @Result = @Result + '\';
        SET @Result = @Result + RTRIM(LTRIM(@Part3));
    END

    IF @Part4 IS NOT NULL
    BEGIN
        IF RIGHT(@Result, 1) != '\' SET @Result = @Result + '\';
        SET @Result = @Result + RTRIM(LTRIM(@Part4));
    END

    RETURN replace(@Result, '/','_');
  --select replace(@Result, '/','_')
END;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnBuildPath] TO PUBLIC
    AS [dbo];

