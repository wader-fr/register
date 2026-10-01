-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInList] 
--	DECLARE
	@IdTypeDoc int = NULL
	,@IdTypeWork int = NULL
	,@Dept varchar(50) = NULL
	,@IdService tinyint = NULL
	,@NoDatePlane int = 0
	,@NoDateEnd int = 0
	,@YearDoc varchar(4) = null
	,@NumIn bigint = null
	,@NumOut varchar(50) = NULL
	,@DateInBeg datetime = NULL
	,@DateInEnd datetime = NULL
	--,@IdGroupDocType int = NULL
	--,@IdGroupWorkType int = NULL
	,@DateContBeg datetime = NULL
	,@DateContEnd datetime = NULL
	,@IdBudget int = NULL
	,@NoEx bit = 0
	,@Contragent varchar(500) = NULL

AS
BEGIN

	SET NOCOUNT ON;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	IF @Dept IS NULL
		SET @Dept = '%';
	ELSE
		SET @Dept = '% ' + @Dept + ' %';

	SET @NumOut = dbo.fnFindIndex(@NumOut,'%');

	SET @Contragent = dbo.fnFindIndex(@Contragent, '%')

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
		
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SELECT di.IdDocIn, di.NumInA, di.DateIn, di.NumOut, di.DateOut, di.NoEx, di.YearDoc, di.NumCancel, di.DateCancel, di.NumCancelOut, di.DateCancelOut ,di.ScanDocIn, di.NumInsp + N' от ' + CONVERT (NVARCHAR, di.DateInsp, 4) Inspection,
		di.DatePlane, di.DateEnd,
		CONVERT (NVARCHAR, di.NumIn) + N'-' + di.Suffics NumInF, 
		CASE WHEN ISNULL(att.c, 0) > 0 THEN 1 ELSE 0 END AttachC,
		CASE WHEN ISNULL(s.c, 0) > 0 THEN 1 ELSE 0 END SubDocC, 
		CASE WHEN ISNULL(sc.c, 0) > 0 THEN 1 ELSE 0 END ScanC, 
		a1.Depts Embed, a1.IdsDept,	a2.Depts Accepted,
		case when c.sName is not null then isnull(pc.Property, '') + ' ' + c.sName else c.fName end Contragent, 
	
		isnull(di.[Object],case when obj.sName is not null then isnull(p.Property, '') + ' ' + obj.sName else obj.fName end)[object] ,
		dt.sDocType, wt.WorkType,
		ct.NumContract + ' от ' + CONVERT(varchar(10), ct.DateContract, 104) NumContract
--
	FROM dbo.tblDocIn di
		LEFT OUTER JOIN dbo.ftAppointment(1) a1 ON a1.IdODoc = di.IdDocIn
		LEFT OUTER JOIN dbo.ftAppointment(2) a2 ON a2.IdODoc = di.IdDocIn
		LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		LEFT OUTER JOIN dbo.tblContragent obj ON obj.IdContragent = di.IdOObject
		left outer join [dbo].[tblProp] p on p.IdProperty = obj.IdOProperty
		left outer join [dbo].[tblProp] pc on pc.IdProperty = c.IdOProperty
		LEFT OUTER JOIN dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
		LEFT OUTER JOIN dbo.tblWorkType wt ON wt.IdWorkType = di.IdOTypeWork
		LEFT OUTER JOIN [dbo].[tContract] ct ON ct.IdContract = di.IdOContract
		LEFT OUTER JOIN (SELECT COUNT(a.IdAttach) c, a.IdODocIn FROM dbo.tAttach a GROUP BY a.IdODocIn) att ON att.IdODocIn = di.IdDocIn
		LEFT OUTER JOIN (SELECT COUNT(sdi.IdSubDocIn) c, sdi.IdODocIn FROM dbo.tSubDocIn sdi GROUP BY sdi.IdODocIn) s ON s.IdODocIn = di.IdDocIn
		LEFT OUTER JOIN (SELECT COUNT(sdi.IdScanIn) c, sdi.IdODocIn FROM dbo.tScanDocIn sdi GROUP BY sdi.IdODocIn) sc ON sc.IdODocIn = di.IdDocIn

	WHERE di.YearDoc = ISNULL(@YearDoc, di.YearDoc)									--Год учета
		AND (ISNULL(c.fName,'') LIKE @Contragent OR ISNULL(c.sName, '') LIKE @Contragent)					--Заявитель
		AND di.NumIn = ISNULL(@NumIn, di.NumIn)										--Входящий номер
		AND isnull(di.NumOut,'') LIKE @NumOut													--Исходящий номер
		AND ISNULL(di.DateIn, GETDATE()) BETWEEN @DateInBeg AND @DateInEnd			--Входящая дата
		AND ISNULL(di.DatePlane, GETDATE()) BETWEEN @DateContBeg AND @DateContEnd	--Контрольный срок
		AND ISNULL(wt.IdOBudget, 0) = COALESCE(@IdBudget, wt.IdOBudget, 0)			--Бюджет
		AND CASE WHEN di.DatePlane IS NULL THEN 1 ELSE 0 END >= @NoDatePlane		--Без контрольного срока
		AND CASE WHEN di.DateEnd IS NULL THEN 1 ELSE 0 END >= @NoDateEnd			--Незавершенные
		AND ISNULL(di.IdOTypeDoc, 0) = COALESCE(@IdTypeDoc, di.IdOTypeDoc, 0)		--Вид документа
		AND ISNULL(di.IdOTypeWork, 0) = COALESCE(@IdTypeWork, di.IdOTypeWork, 0)	--Вид работ
		AND ' ' + ISNULL(a1.IdsDept, '')  + ' ' LIKE @Dept							--Подразделение
		AND di.NoEx <= @NoEx
	
	ORDER BY di.NumIn, di.YearDoc
END
