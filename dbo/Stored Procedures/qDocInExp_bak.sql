CREATE PROCEDURE [dbo].[qDocInExp_bak]
	@IdDocIn bigint
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @ScanPath nvarchar(200) = dbo.fnGetOption('PathPred')
		, @Emps varchar(500)
		, @IdsEmp varchar(50)


	SELECT @Emps = a.Emps, @IdsEmp = a.IdsEmp FROM tAppointment a WHERE a.IdODoc = @IdDocIn

    SELECT di.NumInA, di.NumOut, di.DateOut, di.NumInsp, di.DateInsp, dt.DocType, c.sName customer, o.fName obj, wt.WorkType, di.DeptF, di.NoteDoc, di.DatePlane, di.DateEnd, di.NumCancel, di.DateCancel
		, di.NumCancelOut, di.DateCancelOut--, di.Emps
		, @ScanPath + '\' +di.ScanDocIn scan
		, @Emps Emps
		, @IdsEmp IdsEmp
		,di.AttachC
		,di.SubDocC
	FROM dbo.tblDocIn di
		LEFT OUTER JOIN dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
		LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		LEFT OUTER JOIN dbo.tblContragent o ON o.IdContragent = di.IdOObject
		LEFT OUTER JOIN dbo.tblWorkType wt on wt.IdWorkType = di.IdOTypeWork
	WHERE di.IdDocIn = @IdDocIn


END
