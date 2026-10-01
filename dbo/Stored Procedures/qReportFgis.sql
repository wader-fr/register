

CREATE PROCEDURE [dbo].[qReportFgis]
--	DECLARE
	@Sent bit = 1
	,@DateDocB datetime = NULL
	,@DateDocE datetime = NULL

AS

	--DECLARE @ScanPath nvarchar(500) 
	
	--SET @ScanPath = dbo.fnGetOption('PathScan')

	SELECT do.IdDocOut, do.NumDocOut, do.ANumDocOut, do.DateDocOut, do.DateInspB, do.DateInspE,
		(SELECT	o.NameObject + ' ' + ISNULL(o.pAddress,'') FROM dbo.tblObject o WHERE do.IdOObject = o.IdObject ) AS Object,
		(SELECT r.Result FROM dbo.tblResult AS r WHERE do.IdOResult = r.IdResult) Result, 
		(SELECT e.LastName FROM dbo.tblEmployee e WHERE e.IdEmployee = do.IdOEmp) LastName,
		(SELECT e.FirstName FROM dbo.tblEmployee e WHERE e.IdEmployee = do.IdOEmp) FirstName,
		(SELECT e.Patronimic FROM dbo.tblEmployee e WHERE e.IdEmployee = do.IdOEmp) Patronimic,
		do.PathScan, do.DateSent, do.Sent, do.ScanName, dbo.fnGetPathDocIn(do.IdODocIn) + '\' + do.ScanName  scanf --@ScanPath + '\' + do.ScanName scanf
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
		INNER JOIN dbo.tblDocIn di ON di.IdDocIn = do.IdODocIn
	WHERE do.Sent <= @Sent
		AND do.DateDocOut >= ISNULL(@DateDocB, CONVERT(datetime,'2023-01-03',104))
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
	ORDER BY CASE WHEN do.ScanName IS NULL THEN 1 ELSE 0 END , do.DateDocOut, do.ANumDocOut
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qReportFgis] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qReportFgis] TO [Admin]
    AS [dbo];

