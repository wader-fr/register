-- =============================================
-- Author:		<Fateev Roman>
-- Create date: <2015/12-14>
-- Description:	<Следующий номер входящего документа>
-- =============================================
CREATE FUNCTION [dbo].[fnNextNumIn] (@Year CHAR(4))
RETURNS BIGINT
AS
BEGIN

  DECLARE @ResultVar bigint;

  SELECT
    @ResultVar = ISNULL(MAX(di.NumIn), 0) + 1
  FROM tblDocIn AS di
  WHERE (di.YearDoc = @Year);

  RETURN @ResultVar;

END;


