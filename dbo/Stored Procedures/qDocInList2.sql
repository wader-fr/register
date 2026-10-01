-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInList2] 
--	DECLARE
	@IdTypeDoc int = NULL
	,@IdTypeWork int = NULL
	,@Dept varchar(50) = NULL
	,@IdService tinyint = NULL
	,@NoDatePlane int = 0
	,@NoDateEnd int = 0
	,@YearDoc varchar(4) = NULL
	,@NumIn bigint = NULL
	,@NumOut varchar(50)
	,@DateInBeg datetime = NULL
	,@DateInEnd datetime = NULL
	,@IdGroupDocType int = NULL
	,@IdGroupWorkType int = NULL
	,@DateContBeg datetime = NULL
	,@DateContEnd datetime = NULL
	,@IdBudget int = NULL
	,@NoEx bit = 0

AS
BEGIN

	SET NOCOUNT ON;
	IF @Dept IS NULL
		SET @Dept = '%';
	ELSE
		SET @Dept = '% ' + @Dept + ' %';

	SET @NumOut = dbo.fnFindIndex(@NumOut,'%');

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


		SELECT di.IdDocIn, 
			CONVERT (NVARCHAR, di.NumIn) + N'-' + di.Suffics NumInF, 
			di.DateIn,
			di.NumOut,
			di.DateOut,
			c.sName Contragent,
			ISNULL(obj.sName, obj.fName) [object],
			dt.sDocType,
			wt.WorkType,
			di.DatePlane,
			di.DateEnd,
			di.NumInsp + N' от ' + CONVERT (NVARCHAR, di.DateInsp, 4) Inspection, 
			a1.Depts Embed,
			a2.Depts Accepted,
			a1.IdsDept,
			di.NoEx,
			di.YearDoc,
			di.NumCancel,
			di.DateCancel,
			di.NumCancelOut,
			di.DateCancelOut
			,di.ScanDocIn
			,ct.NumContract + ' от ' + CONVERT(varchar(10), ct.DateContract, 104) NumContract
			,di.IdOContract
			,di.[AttachC]
			,di.[SubDocC]
		FROM dbo.tblDocIn di
			LEFT OUTER JOIN (SELECT a.IdODoc, a.Depts, a.IdsDept FROM dbo.tAppointment a WHERE a.IdOTypeApp = 1) a1 ON a1.IdODoc = di.IdDocIn
			LEFT OUTER JOIN (SELECT a.IdODoc, a.Depts, a.IdsDept FROM dbo.tAppointment a WHERE a.IdOTypeApp = 2) a2 ON a2.IdODoc = di.IdDocIn
			LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
			LEFT OUTER JOIN dbo.tblContragent obj ON obj.IdContragent = di.IdOObject
			LEFT OUTER JOIN dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
			LEFT OUTER JOIN dbo.tblWorkType wt ON wt.IdWorkType = di.IdOTypeWork
			LEFT OUTER JOIN [dbo].[tContract] ct ON ct.IdContract = di.IdOContract
		WHERE --ISNULL(di.IdOTypeDoc, 0) = COALESCE(@IdTypeDoc, di.IdOTypeDoc, 0)
			--AND ISNULL(di.IdOTypeWork, 0) = COALESCE(@IdTypeWork, di.IdOTypeWork, 0)
			(ISNULL(di.IdOTypeDoc, 0) =
				CASE WHEN @IdGroupDocType IS NULL
					THEN COALESCE(@IdTypeDoc, di.IdOTypeDoc, 0)
				END
				OR di.IdOTypeDoc IN (SELECT sgdt.IdODocType FROM dbo.tblSpecGroupDocType sgdt WHERE sgdt.IdOGroupDocType = @IdGroupDocType) )
			AND (ISNULL(di.IdOTypeWork, 0) = 
				CASE WHEN @IdGroupWorkType IS NULL
					THEN  COALESCE(@IdTypeWork,  di.IdOTypeWork, 0) 
				END
				OR di.IdOTypeWork IN (SELECT sgwt.IdOWorkType FROM dbo.tblSpecGroupWorkType sgwt WHERE sgwt.IdOGroupWorkType = @IdGroupWorkType))
			AND ' ' + ISNULL(a1.IdsDept, '')  + ' ' LIKE @Dept
			AND CASE WHEN di.DatePlane IS NULL THEN 1 ELSE 0 END >= @NoDatePlane
			AND CASE WHEN di.DateEnd IS NULL THEN 1 ELSE 0 END >= @NoDateEnd
			AND di.YearDoc = ISNULL(@YearDoc, di.YearDoc)
			AND di.NumIn = ISNULL(@NumIn, di.NumIn)
			AND ISNULL(di.NumOut, '') LIKE @NumOut
			AND ISNULL(di.DateIn, GETDATE()) BETWEEN @DateInBeg AND @DateInEnd
			AND ISNULL(di.DatePlane, '2000-01-01') >= @DateContBeg
			AND ISNULL(di.DatePlane, '2100-01-01') <= @DateContEnd
			AND ISNULL(wt.IdOBudget, 0) = COALESCE(@IdBudget, wt.IdOBudget, 0)
		ORDER BY di.NumIn
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList2] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList2] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList2] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInList2] TO [Admin]
    AS [dbo];

