-- =============================================
-- Author:		Roman
-- Create date: 28.02.2025
-- Description:	Форма списка сканов к входящему №
-- =============================================
CREATE PROCEDURE [dbo].[qScanInExp]
--	DECLARE
	@IdDoc bigint
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Path varchar(1000)
	
	SET @Path = dbo.fnGetOption('PathPred')
	
	SELECT 1 pp, 'Договор № ' + c.NumContract + ' от ' + CONVERT(varchar(10), c.DateContract, 104) [Description], @Path + '\contracts\' + c.ScanContract PathScan, c.ScanContract scan
	FROM [dbo].[tContract] c
		INNER JOIN [dbo].[tblDocIn] di ON di.IdOContract = c.IdContract
	WHERE di.IdDocIn = @IdDoc
	UNION
	SELECT 2 pp, 'Дополнение № ' + sdi.[Description] , @Path + '\' + di.YearDoc +'\' + CONVERT(varchar(10), di.NumIn) + '-' + di.Suffics + '\' + sdi.doc PathScan, sdi.doc
	FROM dbo.tScanDocIn sdi 
		INNER JOIN dbo.tblDocIn di ON di.IdDocIn = sdi.IdODocIn
	WHERE sdi.IdODocIn = @IdDoc

END
