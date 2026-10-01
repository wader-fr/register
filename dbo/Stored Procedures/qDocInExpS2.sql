
CREATE PROCEDURE [dbo].[qDocInExpS2]
--DECLARE
	@IdDocIn bigint = 81778,
	@User varchar(50) = 'Вешнякова'
AS
BEGIN	
	
	DECLARE @Emp varchar(10) = '%',
			@EmpM varchar(10) = '%',
			@Dept varchar(10) = '%',
			@IdEtap int = 1,
			@IdDept int = null,
			@IdEmp int = null,
			@Ex int --= USER_NAME()--'фатеев'--
	
	DECLARE @ScanPath nvarchar(500) = dbo.fnGetOption('PathPred');
	
	SELECT @Emp = '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
	FROM dbo.tblEmployee e 
	WHERE e.lgn = @User
		AND e.Roles NOT LIKE '%Maneger%';
		
	SELECT @EmpM = '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
	FROM dbo.tblEmployee e 
	WHERE e.lgn = @User
	
	SELECT @Dept = '% ' + CONVERT(varchar(10), e.IdODept) + ' %' 
	FROM dbo.tblEmployee e 
	WHERE e.lgn = @User
		AND e.Roles NOT LIKE '%Admin%';

	SELECT @IdEtap = MAX(a.IdOTypeApp), @Ex = -1
	FROM dbo.tAppointment a
	WHERE a.IdODoc = @IdDocIn
			AND a.IdsEmp LIKE @EmpM
			
	IF @IdEtap IS NULL
		SELECT @IdEtap = MAX(a.IdOTypeApp), @Ex =0
		FROM dbo.tAppointment a
		WHERE a.IdODoc = @IdDocIn
				AND a.IdsDept LIKE @Dept

	select @IdDept = e.IdODept, @IdEmp = e.IdEmployee from dbo.tblEmployee e where e.lgn = @User

	--select @Emp emp, @EmpM empM, @Dept dept, @IdDept IdDept, @IdEtap IdEtap, @Ex ex


	SELECT a.IdAppointment, a.IdOTypeApp, a.Depts, a.Emps, a.IdsDept, a.IdsEmp
		,di.NumInA, di.NumOut, di.DateOut, di.NumInsp, di.NoteDoc, di.DateInsp, di.DatePlane, di.DateEnd, di.NumCancel
		,di.DateCancel, di.NumCancelOut, di.DateCancelOut, di.Analisis
		,ta.TypeApp
		,dt.DocType
		,c.fName Customer
		,isnull(di.[Object], obj.fName) Obj,
		wt.WorkType,
		@ScanPath + '\' +di.ScanDocIn scan,
		di.Nom#
		, di.NomYear
		, di.NomFolder
		, di.NomFile
		, di.IdOContract
		, di.[ScanDocIn]
		, @Ex ex
		,'Виза руководства: ' + char(13) + char(10) + isnull( ass.Assignment, '-') + isnull(char(13) + char(10) + char(13) + char(10) + 'Поручение РСП: ' + char(13) + char(10) + asse.Assignment, '') Assignment
FROM dbo.tAppointment a
		INNER JOIN dbo.tblDocIn di ON di.IdDocIn = a.IdODoc
		left outer join dbo.tAssignment ass on ass.IdODocIn = di.IdDocIn and ass.IdODept = @IdDept and ass.IdOEmp is null
		left outer join dbo.tAssignment asse on asse.IdODocIn = di.IdDocIn and a.IdsEmp like  '% ' + convert(varchar(10), asse.IdOEmp ) + ' %' and asse.IdOEmp = @IdEmp
		--left outer join dbo.tAssignment asse on asse.IdODocIn = di.IdDocIn and asse.IdOEmp = @IdEmp
		LEFT OUTER JOIN dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
		LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		LEFT OUTER JOIN dbo.tblContragent obj ON obj.IdContragent = di.IdOObject
		LEFT OUTER JOIN dbo.tblWorkType wt ON wt.IdWorkType = di.IdOTypeWork
		INNER JOIN dbo.tTypeAppointment ta ON ta.IdTypeAppointment = a.IdOTypeApp
	WHERE a.IdODoc = @IdDocIn
			AND a.IdOTypeApp = @IdEtap
END