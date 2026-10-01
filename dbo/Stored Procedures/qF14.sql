Create PROCEDURE [dbo].[qF14]
  --DECLARE
  @DateBeg DATETIME,
  @DateEnd DATETIME
AS

  SELECT
    COALESCE(tob.CodeObj, tob.TypeObj) AS Объект
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 10
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS ПДВ
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 10
      AND do.IdOResult = 2
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS [ПДВ несогл]
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 12
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS ПДС
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 12
      AND do.IdOResult = 2
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS [ПДС несогл]
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 9
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS СЗЗ
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 9
      AND do.IdOResult = 2
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS [СЗЗ несогл]
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 24
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS Прочие
   ,(SELECT
        COUNT(*)
      FROM dbo.vDocOutExec AS do
      WHERE do.IdOTypeObj = tob.IdTypeObj
      AND do.IdOExpType = 24
      AND do.IdOResult = 2
      AND do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
    AS [Прочие несогл]

  FROM dbo.tblTypeObj AS tob
  WHERE tob.exp IS NOT NULL
  
