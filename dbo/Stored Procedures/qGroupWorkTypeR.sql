-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qGroupWorkTypeR]

AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @tbl table (IdGroupWorkType int, GroupWorkType varchar(20))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT *
	FROM dbo.tblGroupWorkType wt

	SELECT * FROM @tbl

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qGroupWorkTypeR] TO PUBLIC
    AS [dbo];

