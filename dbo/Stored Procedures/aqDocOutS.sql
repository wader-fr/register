
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aqDocOutS]
--	DECLARE
	@Suffics char(2)
	,@Emp  int

AS
BEGIN

  SET NOCOUNT ON;

	DECLARE @IdDocOut bigint
	,@Dept int

	SELECT @Dept = e.IdODept
	FROM dbo.tblEmployee e
	WHERE e.IdEmployee = @Emp

	INSERT INTO dbo.tDocOut (Suffics, YearOut, IdOEmp, IdODept)
	VALUES(@Suffics, YEAR(GETDATE()), @Emp, @Dept)

	SET @IdDocOut = @@IDENTITY


  SELECT
    do.IdDocOut
   ,do.NumDocOut
   ,do.Suffics
   ,do.DateDocOut
   ,do.IdODocOut
   ,do.ResigningNum
   ,do.ResigningDate
   ,do.IdOTypeDocOut
   ,do.IdOExpType
   ,do.IdOTypeObj
   ,do.IdOReconstruction
   ,do.IdOObject
   ,do.IdODept
   ,do.IdOEmp
   ,do.IdOResult
   ,do.Note
   ,do.NoEx
   ,do.IdODocIn
   ,do.IdOTypeDocOut
   ,do.SelectionPlace
   ,do.DateInspB
   ,do.DateInspE
   ,do.IdOObjectInsp
   , do.NumProt
   , do.DateProt
   , do.Attestat
	,(SELECT oi.IdOTypeObject FROM dbo.tObjectInsp oi WHERE oi.IdObjectInsp = do.IdOObjectInsp ) IdOTypeObjectInsp
    ,(SELECT oi.ObjectInsp + ' (' + toi.TypeObjectInsp + ')' 
        FROM dbo.tObjectInsp oi 
        INNER JOIN dbo.tTypeObjectInsp toi ON oi.IdOTypeObject = toi.IdTypeObjectInsp 
        WHERE oi.IdObjectInsp = do.IdOObjectInsp) ObjectInsp
   ,(SELECT
        dt.DocType + ' ' + CONVERT(VARCHAR(10), di.NumIn) + '-' + di.Suffics + ' от ' + CONVERT(VARCHAR(10), di.DateIn, 104) + ', ' + c.fName
      FROM dbo.tblDocIn di
      INNER JOIN dbo.tblDocType dt
        ON dt.IdDocType = di.IdOTypeDoc
		INNER JOIN tblContragent c ON c.IdContragent = di.IdOObject
      WHERE di.IdDocIn = do.IdODocIn)
    DocIn
   ,do.PathFile
   ,do.NameFile
   ,(SELECT
        dos.NumDocOut +
        CASE
          WHEN dos.Suffics IS NOT NULL THEN '-' + dos.Suffics
        END
      FROM dbo.tDocOut dos
      WHERE dos.IdDocOut = do.IdODocOut)
    ResNum
   ,(SELECT
        dos.DateDocOut
      FROM dbo.tDocOut dos
      WHERE dos.IdDocOut = do.IdODocOut)
    ResDate
	, do.PathScan
	, do.ScanName
	,(SELECT dto.AutoNumGroup FROM dbo.tblDocTypeOut dto WHERE dto.IdDocTypeOut = do.IdOTypeDocOut) AutoNumGroup
  FROM dbo.tDocOut do
  --LEFT OUTER JOIN dbo.tblDocTypeOut dto
  --  ON do.IdOTypeDocOut = dto.IdDocTypeOut
  WHERE do.IdDocOut = @IdDocOut

END
