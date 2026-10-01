
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInRep]
--	DECLARE
@IdTypeDoc INT = NULL
, @IdTypeWork INT = NULL
, @Dept VARCHAR(50) = NULL
, @IdService TINYINT = NULL
, @NoDatePlane INT = 0
, @NoDateEnd INT = 0
, @YearDoc VARCHAR(4) = NULL
, @NumIn BIGINT = NULL
, @NumOut VARCHAR(15)
, @DateInBeg DATETIME = NULL
, @DateInEnd DATETIME = NULL
, @IdGroupDocType INT = NULL
, @IdGroupWorkType INT = NULL
, @DateContBeg DATETIME = NULL
, @DateContEnd DATETIME = NULL
, @IdBudget INT = NULL
, @NoEx bit = 0
AS
BEGIN

  SET NOCOUNT ON;

  IF @Dept IS NULL
    SET @Dept = '%';
  ELSE
    SET @Dept = '%,' + @Dept + ',%';

  SET @NumOut = dbo.fnFindIndex(@NumOut, '%');

  IF @DateInBeg IS NULL
    SET @DateInBeg = CONVERT(DATETIME, '01.01.1899', 104);

  IF @DateInEnd IS NULL
    SET @DateInEnd = CONVERT(DATETIME, '01.01.2200', 104);

  IF @DateContBeg IS NULL
    SET @DateContBeg = CONVERT(DATETIME, '01.01.1899', 104);

  IF @DateContEnd IS NULL
    SET @DateContEnd = CONVERT(DATETIME, '01.01.2200', 104);

  IF @YearDoc = 0
    SET @YearDoc = NULL

  SELECT di.IdDocIn
   ,NumInF AS [Вх. №]
   ,DateIn AS [Вх. дата]
   ,NumOut AS [Исх. №]
   ,DateOut AS [Исх. дата]
   ,Contragent AS Заявитель
   ,[Object] AS [Объект надзора]
   ,DocType AS [Вид документа]
   ,WorkType AS [Вид работ]
   ,DeptF AS Подразделение
   ,DatePlane AS [Контрольный срок]
   ,DateEnd AS [Дата исполнения]
   ,NoteDoc AS [Кр. содержание]
			,CASE WHEN di.NoEx = 1 THEN 'Да' END Снято 
  FROM dbo.vDocInList di
  WHERE (ISNULL(di.IdOTypeDoc, 0) =
                        CASE
                          WHEN @IdGroupDocType IS NULL THEN ISNULL(di.IdOTypeDoc, 0)
                        END
  OR di.IdOTypeDoc IN (SELECT
      sgdt.IdODocType
    FROM dbo.tblSpecGroupDocType sgdt
    WHERE sgdt.IdOGroupDocType = @IdGroupDocType)
  )
  AND (ISNULL(di.IdOTypeWork, 0) =
                       CASE
                         WHEN @IdGroupWorkType IS NULL THEN ISNULL(di.IdOTypeWork, 0)
                       END
  OR di.IdOTypeWork IN (SELECT
      sgwt.IdOWorkType
    FROM dbo.tblSpecGroupWorkType sgwt
    WHERE sgwt.IdOGroupWorkType = @IdGroupWorkType)
  )
  AND ISNULL(di.IdOTypeDoc, 0) = COALESCE(@IdTypeDoc, di.IdOTypeDoc, 0)
  AND ISNULL(di.IdOTypeWork, 0) = COALESCE(@IdTypeWork, di.IdOTypeWork, 0)
  AND ',' + ISNULL(di.Dept, '') + ',' LIKE @Dept
  AND di.DatePlaneNull >= @NoDatePlane
  AND di.DateEndNull >= @NoDateEnd
  AND di.YearDoc = ISNULL(@YearDoc, di.YearDoc)
  AND di.NumIn = ISNULL(@NumIn, di.NumIn)
  AND ISNULL(di.NumOut, '') LIKE @NumOut
  AND ISNULL(di.IdOTypeDoc, 0) = COALESCE(@IdTypeDoc, di.IdOTypeDoc, 0)
  AND ISNULL(di.DateIn, GETDATE()) BETWEEN @DateInBeg AND @DateInEnd
  AND ISNULL(di.DatePlane, '2000-01-01') >= @DateContBeg
  AND ISNULL(di.DatePlane, '2100-01-01') <= @DateContEnd
  AND ISNULL(di.IdOBudget, 0) = COALESCE(@IdBudget, di.IdOBudget, 0)
  AND di.NoEx <= @NoEx
  ORDER BY di.NumIn

END
