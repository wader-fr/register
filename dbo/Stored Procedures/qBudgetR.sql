-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qBudgetR]
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @tbl table (IdBudget tinyint, Budget varchar(5))

	INSERT INTO @tbl
	VALUES (0, '<Все>')

	INSERT INTO @tbl
	SELECT b.IdBudget, b.Budget
	FROM dbo.tblBudget b

	SELECT * FROM @tbl

END
