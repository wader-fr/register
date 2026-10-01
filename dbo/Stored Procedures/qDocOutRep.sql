
CREATE PROCEDURE [dbo].[qDocOutRep]

--DECLARE
	@NumOut varchar(50) = NULL
	,@NumIn int = NULL
	--,@Year varchar(4) = NULL
	,@TypeDoc int = NULL
	,@TypeExp int = NULL
	,@Result smallint = NULL
	,@Dept int = NULL
	,@Emp int = NULL
	,@Contragent varchar(300) = NULL
	,@NoEx bit = -1
	,@OutAA int = 0
	,@IdNumIn int = NULL
	,@Sent bit = -1
	,@DateDocB DateTime = NULL
	,@DateDocE DateTime = NULL
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ScanPath nvarchar(255) 
	SET @ScanPath = dbo.fnGetOption('PathScan')

	SET @Contragent = dbo.fnFindIndex(@Contragent, '%');
	IF @IdNumIn = 0 SET @IdNumIn = NULL
	IF @Emp = 0 SET @Emp = NULL
	IF @Dept = 0 SET @Emp = NULL

	SELECT 
			do.IdDocOut
			,do.NumDocOut + '-' + do.Suffics [Исх. №]
			,do.DateDocOut [Исх. дата]
			,dto.DocTypeOut Вид
			,ex.ExpType Экспертиза
			,COALESCE(obj.NameObject, o.sName, c.sName) [Объект экспертизы]
			,d.sNameDept Отдел
			,dbo.fnInitial(e.LastName + ' ' + e.FirstName + ' ' + e.Patronimic) Исполнитель
			,r.Result Результат
			,CONVERT(varchar(10),di.NumIn) + '-' + do.Suffics + ' от ' + CONVERT(varchar(10),di.DateIn,104) Основание
			,CASE WHEN do.NoEx = 1 THEN 'Да' END Снято 
	FROM dbo.tDocOut do
		LEFT OUTER JOIN [dbo].[tblDocIn] di ON di.IdDocIn = do.IdODocIn
		LEFT OUTER JOIN [dbo].[tblDocTypeOut] dto ON dto.IdDocTypeOut = do.IdOTypeDocOut
		LEFT OUTER JOIN dbo.tblExp ex ON ex.IdExpType = do.IdOExpType
		LEFT OUTER JOIN dbo.tblResult r ON r.IdResult = do.IdOResult
		LEFT OUTER JOIN dbo.tblDept d ON d.IdDept = do.IdODept
		LEFT OUTER JOIN dbo.tblEmployee e ON e.IdEmployee = do.IdOEmp
		LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		LEFT OUTER JOIN dbo.tblContragent o ON o.IdContragent = di.IdOObject
		LEFT OUTER JOIN dbo.tblObject obj ON do.IdOObject = obj.IdObject
	WHERE
		(ISNULL(do.NumDocOut, '') = COALESCE(@NumOut, do.NumDocOut, '') OR ISNULL(CONVERT(nvarchar(50), do.ANumDocOut), '') = COALESCE(@NumOut, CONVERT(nvarchar(50), do.ANumDocOut), ''))
		AND ISNULL(di.NumIn, 0) = COALESCE(@NumIn, di.NumIn, 0)
		--AND ISNULL(do.YearOut, '') = COALESCE(@Year, do.YearOut, '')
		AND ISNULL(dto.AutoNumGroup, 0) = CASE WHEN @TypeDoc = -1 THEN 1 ELSE ISNULL(dto.AutoNumGroup, 0) END
		AND ISNULL(do.IdOTypeDocOut, 0) = CASE WHEN @TypeDoc IS NULL THEN ISNULL(do.IdOTypeDocOut, 0) WHEN @TypeDoc = -1 THEN do.IdOTypeDocOut ELSE @TypeDoc END
		AND ISNULL(do.IdOExpType, 0) = COALESCE(@TypeExp, do.IdOExpType, 0)
		AND ISNULL(do.IdOResult, 0) = COALESCE(@Result, do.IdOResult, 0)
		AND ISNULL(do.IdODept, 0) = COALESCE(@Dept, do.IdODept, 0)
		AND ISNULL(do.IdOEmp, 0) = COALESCE(@Emp, do.IdOEmp, 0)
		AND (ISNULL(c.fName, '') LIKE @Contragent 
				OR ISNULL(c.sName, '') LIKE @Contragent
				OR ISNULL(o.fName, '') LIKE @Contragent
				OR ISNULL(o.sName, '') LIKE @Contragent)
		AND do.[NoEx] <= @NoEx
		AND do.OutAA = CASE WHEN @OutAA = -1 THEN do.OutAA ELSE @OutAA END
		AND do.IdODocIn = ISNULL(@IdNumIn, do.IdODocIn)
		AND do.[Sent] <= @Sent
		AND do.DateDocOut BETWEEN ISNULL(@DateDocB, '1900-01-01') AND ISNULL(@DateDocE, '2200-01-01');

END
