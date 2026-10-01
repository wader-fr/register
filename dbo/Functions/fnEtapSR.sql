-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnEtapSR]
(
	@pos int
)
RETURNS varchar(150)
AS
BEGIN

	DECLARE @Result varchar(150)
	DECLARE @tbl table (Pos int, s varchar(150))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdTypeAppointment), ta.[TypeApp]
	FROM dbo.tTypeAppointment ta
	ORDER BY ta.IdTypeAppointment

	SELECT @Result = t.s FROM @tbl t WHERE t.Pos = @pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEtapSR] TO PUBLIC
    AS [dbo];

