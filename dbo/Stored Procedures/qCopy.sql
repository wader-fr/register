
CREATE PROCEDURE [dbo].[qCopy]

AS
SELECT        '\\lis-serv\ScanPred' + tblDocIn.ScanPathDocIn + '\' + tblDocTypeOut.sDocTypeOut + ' ' + tDocOut.ScanName pp, tDocOut.PathScan
FROM            tblDocIn INNER JOIN
                         tDocOut ON tblDocIn.IdDocIn = tDocOut.IdODocIn INNER JOIN
                         tblDocTypeOut ON tDocOut.IdOTypeDocOut = tblDocTypeOut.IdDocTypeOut
WHERE ScanName IS NOT NULL AND PathScan IS NOT NULL
