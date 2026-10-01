
CREATE PROCEDURE [dbo].[qDocApp]

--	DECLARE
		@IdEmp int = NULL,
		@IdDept int = NULL,
		@ViewClosed bit = 0,
		@NumIn varchar(20) = NULL,
		@DateInB datetime = NULL,
		@DateInE datetime = NULL,
		@IdEtap int = 0
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @Emp varchar(20) = '%', @Dept varchar(20) = '%', @User varchar(150) = USER_NAME()
---------------------------------------------------------------------------------------------------------------------------
	SET @DateInB = ISNULL(@DateInB, '2000-01-01')
	SET @DateInE = ISNULL(@DateInE, '2200-01-01')
---------------------------------------------------------------------------------------------------------------------------
	IF @IdEtap = 0 SET @IdEtap = NULL
	IF @IdEmp = 0 SET @IdEmp = NULL
	IF @IdDept = 0 SET @IdDept = NULL
---------------------------------------------------------------------------------------------------------------------------

	IF @IdDept IS NULL
		SELECT @Dept = '% ' + CONVERT(varchar(10), e.IdODept) + ' %' 
		FROM dbo.tblEmployee e 
		WHERE e.lgn = @User
			--AND e.Roles NOT LIKE '%Maneger%'
			AND e.Roles NOT LIKE '%Admin%'
	ELSE
		SET @Dept = '% ' + CONVERT(varchar(10), @IdDept) + ' %'
	
	
	IF @IdEmp IS NULL
		SELECT @Emp = '% ' + CONVERT(varchar(10), e.IdEmployee) + ' %'
		FROM dbo.tblEmployee e 
		WHERE e.lgn = @User
			AND e.Roles NOT LIKE '%Maneger%'
			AND e.Roles NOT LIKE '%Admin%';
	ELSE
		SET @Emp = '% ' + CONVERT(varchar(10), @IdEmp) + ' %';

---------------------------------------------------------------------------------------------------------------------------
select di.IdDocIn, di.NumInA, di.NumOut, di.DateOut, di.DatePlane, di.ScanDocIn, di.Nom#, di.NomYear, di.NomFolder, di.NomFile, di.IdOContract 
	,a.IdOTypeApp
	,a1.Depts DeptsEmb
	,a2.Emps EmpsEmb
	,a3.Depts DeptsAss, a3.Emps EmpsAss
	,ta.TypeApp
	,c.sName Customer
	,wt.WorkType
	,dt.DocType
	,ct.NumContract + ' от ' + convert(varchar(10), isnull(ct.DateContract,''), 104) NumContract
	,isnull(att.c, 0) AttachC
	,isnull(sdi.c, 0) SubDocC
	,isnull(sc.c, 0) ScanC
from dbo.tblDocIn di
	inner join (
				select max(a.IdOTypeApp)IdOTypeApp , IdODoc
				from dbo.tAppointment a
				group by a.IdODoc
				) a on a.IdODoc = di.IdDocIn
	left outer join dbo.tAppointment a1 on a1.IdOTypeApp = 1 and a1.IdODoc = di.IdDocIn
	left outer join dbo.tAppointment a2 on a2.IdOTypeApp = 2 and a2.IdODoc = di.IdDocIn	
	left outer join dbo.tAppointment a3 on a3.IdOTypeApp = 3 and a3.IdODoc = di.IdDocIn
	inner join dbo.tTypeAppointment ta on ta.IdTypeAppointment = a.IdOTypeApp
	left outer join dbo.tblContragent c on	c.IdContragent = di.IdOContragent
	left outer join dbo.tblWorkType wt on wt.IdWorkType = di.IdOTypeWork
	left outer join dbo.tblDocType dt on dt.IdDocType = di.IdOTypeDoc
	left outer join dbo.tContract ct on ct.IdContract = di.IdOContract
	left outer join (select distinct 1 c, a.IdODocIn from dbo.tAttach a ) att on att.IdODocIn = di.IdDocIn
	left outer join (select distinct 1 c, sdi.IdODocIn from dbo.tSubDocIn sdi) sdi on sdi.IdODocIn = di.IdDocIn
	left outer join (select distinct 1 c, sdi.IdODocIn from dbo.tScanDocIn sdi) sc on sc.IdODocIn = di.IdDocIn
	WHERE di.NumIn LIKE ISNULL(@NumIn, '%')
			AND ISNULL(a1.IdsDept, '') LIKE @Dept
			AND ISNULL(a2.IdsEmp, '') LIKE @Emp
			AND a.IdOTypeApp = ISNULL(@IdEtap, a.IdOTypeApp)
			AND a.IdOTypeApp < @ViewClosed + 6
			AND di.DateIn BETWEEN @DateInB AND @DateInE

END
