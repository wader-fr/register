
CREATE PROCEDURE [dbo].[qReportFgisReg]

--DECLARE 
	@DateDocB datetime
	,@DateDocE datetime

AS	
	DECLARE 
		@AllProt int --Подлежит передаче
		,@ProtOK int --Передано в срок
		,@ProtNo int --Не передано
		,@ProtBad int --Передано с нарушением

	SET @DateDocB = ISNULL(@DateDocB, CONVERT(datetime,'2023-01-03', 104))

--Подлежит передаче ===========================================================================================================================================================
	SELECT @AllProt = COUNT(*)
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL

-- Передано в срок ============================================================================================================================================================
	SELECT @ProtOK = COUNT(*)
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
		AND do.Sent = 1
		AND dbo.fnDateDiff(do.DateDocOut, ISNULL(do.DateSent, GETDATE())) < 10

-- Не передано ================================================================================================================================================================
	SELECT @ProtNo = COUNT(*)
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
		AND do.Sent = 0
		AND dbo.fnDateDiff(do.DateDocOut, ISNULL(do.DateSent, GETDATE())) >= 10
	
-- Нарушение сроков============================================================================================================================================================
	SELECT @ProtBad = COUNT(*)
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
		AND dbo.fnDateDiff(do.DateDocOut, do.DateSent) >= 10


		SELECT 1 npp,'Подлежит передаче' Статус, @AllProt Количество
		UNION SELECT 2, 'Передано в срок', @ProtOK
		UNION SELECT 3, 'Не передано', @ProtNo
		UNION SELECT 4, 'Передано с нарушением сроков', @ProtBad


	SELECT do.NumDocOut Номер, do.DateDocOut Дата, dbo.fnDateDiff(do.DateDocOut, do.DateSent) Срок, do.DateSent Передано
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
		AND dbo.fnDateDiff(do.DateDocOut, do.DateSent)>=10

	SELECT do.NumDocOut Номер, do.DateDocOut Дата
	FROM dbo.tDocOut AS do
		INNER JOIN dbo.tblDocTypeOut AS dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
	WHERE do.DateDocOut >= @DateDocB
		AND do.DateDocOut <= ISNULL(@DateDocE, do.DateDocOut)
		AND dto.AutoNumGroup = 1
		AND do.NoEx = 0
		AND do.OutAA = 0
		AND do.ANumDocOut IS NOT NULL
		AND do.Sent = 0
		AND dbo.fnDateDiff(do.DateDocOut, ISNULL(do.DateSent, GETDATE())) >= 10
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qReportFgisReg] TO [SenderFGIS]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qReportFgisReg] TO [Admin]
    AS [dbo];

