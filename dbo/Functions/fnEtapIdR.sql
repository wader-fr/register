-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnEtapIdR]
(
	@pos int
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	DECLARE @tbl table (Pos int, Id int)

	INSERT INTO @tbl
	VALUES (0, 0)

	INSERT INTO @tbl
	SELECT ROW_NUMBER() OVER (ORDER BY IdTypeAppointment), ta.[IdTypeAppointment]
	FROM dbo.tTypeAppointment ta
	ORDER BY ta.IdTypeAppointment

	SELECT @Result = t.Id FROM @tbl t WHERE t.Pos = @pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnEtapIdR] TO PUBLIC
    AS [dbo];

