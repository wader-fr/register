-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDeptR]
	@IdFil int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @tbl table (IdDept int, sNameDept varchar(50))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT d.IdDept, d.sNameDept
	FROM dbo.tblDept d
	WHERE (d.IdOFilial = ISNULL(@IdFil, d.IdOFilial) OR @IdFil = 0) AND d.Act = 1

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDeptR] TO PUBLIC
    AS [dbo];

