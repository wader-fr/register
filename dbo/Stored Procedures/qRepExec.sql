CREATE PROCEDURE [dbo].[qRepExec]

@DateBeg DATETIME,
@DateEnd DATETIME

AS
  SET NOCOUNT ON;
  DECLARE @1a INT
         ,@2a INT
         ,@3a INT
         ,@4a INT;

  DECLARE @Tabl TABLE (
    Категория VARCHAR(50)
   ,Госзадание INT
   ,Госуслуга INT
   ,СЭД INT
   ,[Госуслуга ПРУ] INT
  );

  -- Зарегистрировано по ГЗ
  SELECT
    @1a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeDoc IN (3, 4, 6, 9))
  AND (di.DateIn BETWEEN @DateBeg AND @DateEnd);

  -- Зарегистрировано по ГУ (ФБ)
  SELECT
    @2a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeWork IN (1, 2, 3, 11, 33, 32, 10))
  AND (di.DateIn BETWEEN @DateBeg AND @DateEnd);

  -- Зарегистрировано СЭД
  SELECT
    @3a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.DateIn BETWEEN @DateBeg AND @DateEnd)
  AND (di.NumOut LIKE N'%СЭД%');

  --Зарегистрировано ГУ (ПРУ)

  SELECT
    @4a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.DateIn BETWEEN @DateBeg AND @DateEnd)
  AND (di.IdOTypeWork IN (7, 27, 8, 9, 12, 5, 4));

  INSERT INTO @Tabl --(ZagSt, GZ, GU, SED, GU_PRU)
    VALUES ('Кол. входящих за период', @1a, @2a, @3a, @4a);

  --------------------------------------------------------------------------------------------------------------------------------------

  SELECT
    @1a = COUNT(do.IdDocOut)
  FROM dbo.tblDocIn AS di
  INNER JOIN dbo.vDocOutExec AS do
    ON di.IdDocIn = do.IdODocIn
  WHERE (di.IdOTypeDoc IN (3, 4, 6, 9))
  AND (do.IdOTypeDocOut = 9)
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
  AND do.NoEx <> 1;

  SELECT
    @2a = COUNT(do.IdDocOut)
  FROM dbo.tblDocIn AS di
  INNER JOIN dbo.vDocOutExec AS do
    ON di.IdDocIn = do.IdODocIn
  WHERE (di.IdOTypeWork IN (1, 2, 3, 11, 33, 32, 10))
  AND (do.IdOTypeDocOut = 9)
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
  AND do.NoEx <> 1;

  SET @3a = NULL;

  SELECT
    @4a = COUNT(do.IdDocOut)
  FROM dbo.tblDocIn AS di
  INNER JOIN dbo.tDocOut AS do
    ON di.IdDocIn = do.IdODocIn
  WHERE (di.IdOTypeWork IN (7, 27, 8, 9, 12, 5, 4))
  AND (do.IdOTypeDocOut = 9)
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
  AND do.NoEx <> 1;

  INSERT INTO @Tabl --(ZagSt,GZ, GU, SED,GU_PRU)
    VALUES ('Отозвано за период', @1a, @2a, @3a, @4a);

  -------------------------------------------------------------------------------------------------------------------------------------

  SET @1a = NULL;
  SET @2a = NULL;
  SET @4a = NULL;

  SELECT
    @3a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.NumOut LIKE N'%СЭД%')
  AND (di.DateEnd BETWEEN @DateBeg AND @DateEnd);


  INSERT INTO @Tabl --(ZagSt,GZ, GU, SED,GU_PRU)
    VALUES ('Снято с контроля за период', @1a, @2a, @3a, @4a);

  -------------------------------------------------------------------------------------------------------------------------------------

  SELECT
    @1a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeDoc IN (3, 4, 6, 9))
  AND (di.DateEnd IS NULL)
  AND (di.DateIn <= @DateEnd);


  SELECT
    @2a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeWork IN (1, 2, 3, 11, 33, 32, 10))
  AND (di.DateEnd IS NULL)
  AND (di.DateIn <= @DateEnd);

  /*
  SELECT        COUNT(ID_DocIn) AS Expr1
  FROM            tblDocIn AS di
  WHERE        (Type_Work IN (1, 2, 3, 11, 33, 32)) AND (Date_end IS NULL) AND (Date_in <= CONVERT(DATETIME, '2016-06-30 00:00:00', 102))
  
  */

  SELECT
    @3a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.NumOut LIKE N'%СЭД%')
  AND (di.DateEnd IS NULL)
  AND (di.IdOTypeWork = 21)
  AND (di.DateIn <= @DateEnd);


  SELECT
    @4a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.DateEnd IS NULL)
  AND (di.IdOTypeWork IN (7, 27, 8, 9, 12, 5, 4))
  AND (di.DateIn <= @DateEnd);

  INSERT INTO @Tabl --(ZagSt,GZ, GU, SED,GU_PRU)
    VALUES ('В работе', @1a, @2a, @3a, @4a);

  --------------------------------------------------------------------------------------------------------------------------------------

  SELECT
    @1a = COUNT(do.IdDocOut)
  FROM dbo.tblDocIn AS di
  RIGHT OUTER JOIN dbo.tDocOut AS do
    ON di.IdDocIn = do.IdODocIn
  WHERE (di.IdOTypeDoc IN (3, 4, 6, 9, 18))
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
  AND (do.IdOTypeDocOut IN (1, 2));

  SELECT
    @2a = COUNT(do.IdDocOut)
  FROM dbo.tDocOut AS do
  WHERE (do.IdOTypeDocOut IN (1, 2))
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd)
  AND (do.IdOExpType IN (1, 2, 4, 3, 5, 25, 26));

  SET @3a = NULL;

  SELECT
    @4a = COUNT(do.IdDocOut)
  FROM dbo.tDocOut AS do
  WHERE (do.IdOExpType IN (13, 9, 10, 6, 7, 11, 15))
  AND (do.IdOTypeDocOut IN (1, 2))
  AND (do.DateDocOut BETWEEN @DateBeg AND @DateEnd);

  INSERT INTO @Tabl --(ZagSt, GZ, GU, SED, GU_PRU)
    VALUES ('Подготовлено исходящих', @1a, @2a, @3a, @4a);

  --------------------------------------------------------------------------------------------------------------------------------------
  SELECT
    @1a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeDoc IN (3, 4, 6, 9))
  AND (di.DateEnd BETWEEN @DateBeg AND @DateEnd);

  -- Выполнено по ГУ (ФБ)
  SELECT
    @2a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeWork IN (1, 2, 3, 11, 33, 32, 10))
  AND (di.DateEnd BETWEEN @DateBeg AND @DateEnd);

  -- Выполнено СЭД
  SELECT
    @3a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.NumOut LIKE N'%СЭД%')
  AND (di.DateEnd BETWEEN @DateBeg AND @DateEnd);


  --Выполнено ГУ (ПРУ) 
  SELECT
    @4a = COUNT(di.IdDocIn)
  FROM dbo.tblDocIn AS di
  WHERE (di.IdOTypeWork IN (7, 27, 8, 9, 12, 5, 4))
  AND (di.DateEnd BETWEEN @DateBeg AND @DateEnd);


  INSERT INTO @Tabl --(ZagSt, GZ, GU, SED, GU_PRU)
    VALUES ('Выполнено за отчетный период', @1a, @2a, @3a, @4a);


  SELECT
    *
  FROM @Tabl; 


