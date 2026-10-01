
CREATE PROCEDURE [dbo].[qDocOutS]
--	DECLARE
		@IdDocOut BIGINT = 102020
AS
BEGIN
	DECLARE @ResNum nvarchar(20), 
		@ResDate datetime, 
		@ScanPath nvarchar(1000),
		@ScanName nvarchar(150),
		@NameFile nvarchar(150)

	select @ScanPath = dbo.fnGetPathDocIn(di.IdDocIn), @ScanName = dto.sDocTypeOut + ' ' + do.NumDocOut + '.pdf', @NameFile = dto.sDocTypeOut + ' ' + do.NumDocOut
			, @ResNum = dor.NumDocOut, @ResDate = dor.DateDocOut
	from [dbo].[tDocOut] do
		inner join [dbo].[tblDocIn] di on di.IdDocIn = do.IdODocIn
		left outer join [dbo].[tblDocTypeOut] dto on dto.IdDocTypeOut= do.IdOTypeDocOut
		left outer join [dbo].[tDocOut] dor on dor.IdDocOut = do.IdODocOut
	where do.IdDocOut = @IdDocOut

	SELECT do.NumDocOut
		, do.DateDocOut
		, isnull(@ResNum, do.ResigningNum) ResigningNum
		, isnull(@ResDate, do.ResigningDate) ResigningDate
		--, do.ResigningNum
		--, do.ResigningDate
		, do.DateInspB
		, do.DateInspE
		, do.IdOTypeDocOut
		, do.IdOExpType
		, do.IdOTypeObj
		, do.IdOReconstruction
		, (SELECT oi.ObjectInsp + ' (' + toi.TypeObjectInsp + ')' FROM dbo.tObjectInsp AS oi INNER JOIN dbo.tTypeObjectInsp AS toi ON oi.IdOTypeObject = toi.IdTypeObjectInsp WHERE(oi.IdObjectInsp = do.IdOObjectInsp)) ObjInsp
		, do.IdOObject
		, do.IdODept
		, do.IdOEmp
		, do.IdOResult
		, do.noTLC
		, do.Note
		, (SELECT dt.DocType + ' ' + CONVERT(VARCHAR(10), di.NumIn) + '-' + di.Suffics + ' от ' + CONVERT(VARCHAR(10), di.DateIn, 104) + ', ' + ISNULL(c.fName, '') FROM dbo.tblDocIn AS di INNER JOIN dbo.tblDocType AS dt ON dt.IdDocType = di.IdOTypeDoc LEFT JOIN dbo.tblContragent AS c ON c.IdContragent = di.IdOObject WHERE(di.IdDocIn = do.IdODocIn)) AS DocIn
		, do.OutAA
		, do.NoEx
		, do.Sent
		, do.IdODocIn
		, do.IdODocOut
		, dto.AutoNumGroup
		, @ResNum ResNum
		, @ResDate ResDate
		, @ScanPath PathScan
		, do.NameFile
		, do.ScanName
		, @ScanPath + '\' + isnull(do.ScanName, @ScanName) fScanName
		, @ScanPath + '\' + isnull(do.NameFile, @NameFile) fNameFile
	FROM dbo.tDocOut do 
		LEFT OUTER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut

	WHERE do.IdDocOut = @IdDocOut
END
