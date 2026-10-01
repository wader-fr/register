-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInList11] 
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
		SET @Dept = '%,' + @Dept + ',%';

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

	SELECT di.IdDocIn
			,di.NumInF
			,di.DateIn
			,di.NumOut
			,di.DateOut
			,di.Contragent
			,di.[Object]
			,di.DocType
			,di.DeptF
			,di.WorkType
			,di.DatePlane
			,di.DateEnd
			,di.Inspection
			,di.NoEx
			,di.YearDoc
			,di.NumCancel
			,di.DateCancel
			,di.NumCancelOut
			,di.DateCancelOut
			,(SELECT COUNT(*) FROM dbo.tSubDocIn sdi WHERE sdi.IdODocIn = di.IdDocIn) CountSub
			,di.ScanDocIn
			,di.Depts
			,di.IdsDept

	FROM dbo.vDocInList di
	WHERE 
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
			AND ',' + ISNULL(di.Dept, '') +',' LIKE @Dept
			AND di.DatePlaneNull >= @NoDatePlane
			AND di.DateEndNull >= @NoDateEnd
			AND di.YearDoc = ISNULL(@YearDoc, di.YearDoc)
			AND di.NumIn = ISNULL(@NumIn, di.NumIn)
			AND ISNULL(di.NumOut, '') LIKE @NumOut
			AND ISNULL(di.IdOTypeDoc,0) = COALESCE(@IdTypeDoc, di.IdOTypeDoc,0)
			AND ISNULL(di.DateIn, GETDATE()) BETWEEN @DateInBeg AND @DateInEnd
			AND ISNULL(di.DatePlane,'2000-01-01') >= @DateContBeg
			AND ISNULL(di.DatePlane,'2100-01-01') <= @DateContEnd
			AND ISNULL(di.IdOBudget, 0) = COALESCE(@IdBudget, di.IdOBudget, 0)
			AND di.NoEx < = @NoEx
	ORDER BY di.NumIn

END
