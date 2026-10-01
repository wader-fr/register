

CREATE PROCEDURE [dbo].[qDocInExpert1]

--declare
		@IdEmp int = null,			--Код сотрудника
		@IdDept int = null,			--Код отдела
		@ViewClosed bit = 0,		--Показать пробы на этапе "Завершено"
		@NumIn varchar(20) = null,	--Фильтр по входящему номеру
		@DateInB datetime = null,	--Фильровать по заданному диапазону дат
		@DateInE datetime = null,
		@IdEtap int = 0,			--Фильровать по выбранному этапу
		@User varchar(150)			--Текущий пользователь, вошедший в систему

as
begin
	
	SET NOCOUNT ON;

	--Если не указаны отдел или сотрудник указать любое совпадение
	declare @Emp varchar(20) = '%'
			,@Dept varchar(20) = '%'
			--,@User varchar(150) = 'Фатеев' --USER_NAME()

	--если не заданы диапазоны дат, ставим заведомо большой диапазон
	set @DateInB = ISNULL(@DateInB, '2000-01-01')
	set @DateInE = ISNULL(@DateInE, '2200-01-01')

	if @IdEtap = 0 set @IdEtap = NULL
	if @IdEmp = 0 set @IdEmp = NULL
	if @IdDept = 0 set @IdDept = NULL

	if @IdDept is null 
		--если отдел в фильтре не указан явно, всем, кроме Админа указываем его собственный отдел. Админ может видеть все
		select @Dept = '% ' + convert(varchar(10), e.IdODept) + ' %' from dbo.tblEmployee e where e.lgn = @User and e.Roles not like '%Admin%'
	else
		--Если отдел явно указан, создаем поисковый признак по отделу. Для Админа тоже - он выбирает явно в фильтре
		set @Dept = '% ' + convert(varchar(10), @IdDept) + ' %'
	
	
	if @IdEmp IS NULL
		--если сотрудникв фильтре не указан явно, всем, кроме Менеджера и Админа устанавливаем фильтр, чтобы сотрудники видели только свои назначения
		select @Emp = '% ' + convert(varchar(10), e.IdEmployee) + ' %' from dbo.tblEmployee e where e.lgn = @User and e.Roles NOT LIKE '%Maneger%' and e.Roles NOT LIKE '%Admin%';
	else
		--если сотрудник указан явно, устанавливаем поисковый признак по сотруднику
		set @Emp = '% ' + convert(varchar(10), @IdEmp) + ' %';

	SELECT ta.TypeApp, a.IdOTypeApp, 
		isnull(att.c, 0) AttachC,
		isnull(s.c, 0) SubDocC,
		isnull(sc.c, 0) ScanC,
		di.IdDocIn, di.NumInA, di.NumOut, di.DateOut, di.DatePlane, di.ScanDocIn, di.Nom#, di.NomYear, di.NomFolder, di.NomFile, di.IdOContract,
		a1.Depts DeptsEmb, a2.Emps EmpsEmb, a3.Depts DeptsAcc, a3.Emps EmpsAcc,
		wt.WorkType,
		dt.DocType,
		c.fName Customer,
		ct.NumContract
	from dbo.tblDocIn di
		--соединение с запросом текущего этапа для конкретного отдела и/или сотрудника
		inner join (select max(a.IdOTypeApp) IdOTypeApp, a.IdODoc 
					from dbo.tAppointment a 
					where (isnull(a.IdsDept, '') like @Dept and
						isnull(a.IdsEmp, '') like @Emp) or a.IdOTypeApp = 6
					group by a.IdODoc) a on a.IdODoc = di.IdDocIn
		left outer join dbo.tAppointment a1 on a1.IdODoc = di.IdDocIn and a1.IdOTypeApp = 1
		left outer join dbo.tAppointment a2 on a2.IdODoc = di.IdDocIn and a2.IdOTypeApp = 2
		left outer join dbo.tAppointment a3 on a3.IdODoc = di.IdDocIn and a3.IdOTypeApp = 2
		inner join tTypeAppointment ta ON ta.IdTypeAppointment = a.IdOTypeApp
		left outer join dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		left outer join dbo.tblWorkType wt ON wt.IdWorkType = di.IdOTypeWork
		left outer join dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
		left outer join (select distinct 1 c, a.IdODocIn from dbo.tAttach a) att on att.IdODocIn = di.IdDocIn
		left outer join (select distinct 1 c, sdi.IdODocIn from dbo.tSubDocIn sdi) s on s.IdODocIn = di.IdDocIn
		left outer join (select distinct 1 c, sdi.IdODocIn from dbo.tScanDocIn sdi) sc on sc.IdODocIn = di.IdDocIn
		left outer join dbo.tContract ct ON ct.IdContract = di.IdOContract
	where di.NumIn like isnull(@NumIn, '%')
			and isnull(a1.IdsDept, '') like @Dept
			and isnull(a2.IdsEmp, '') like @Emp
			and a.IdOTypeApp = isnull(@IdEtap, a.IdOTypeApp)
			and a.IdOTypeApp < @ViewClosed + 6
			and di.DateIn between @DateInB and @DateInE
	order by di.YearDoc, di.NumIn
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExpert1] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExpert1] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExpert1] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExpert1] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExpert1] TO [Admin]
    AS [dbo];

