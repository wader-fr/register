CREATE procedure dbo.qSMeasPlanExList
--declare
	@IdEmp int
	,@IdDept int
	,@IdDocIn bigint
	,@ViewClosed bit
as
begin
	set nocount on
	declare @EmpFltr nvarchar(20)

	if isnull(IS_ROLEMEMBER('admin'), 0) = 1
		or isnull(IS_ROLEMEMBER('Maneger'), 0) = 1
			set @EmpFltr = N'%'
	else
		select  @EmpFltr =  N'% ' +  cast(e.IdEmployee as nvarchar(5)) + N' %'
		from [dbo].[tblEmployee] e
			inner join [dbo].[tblDept] d on d.IdDept = e.IdODept
		where e.lgn = SYSTEM_USER


	select  smp.*, di.NumInA, smt.sMeasType, smDraft.IdOEmp, e.IdODept, e.FullName, d.sNameDept, ls.*
	from [dbo].[tSMeasPlan] smp
		--подцепляем черновик
		inner join [dbo].[tSMeasStatus] smDraft on smDraft.IdOSMeasPlan = smp.IdSMeas and smDraft.IdOStatus = 1
			--подцепляем автора черновика
			inner join dbo.tblEmployee e on e.IdEmployee = smDraft.IdOEmp
				--отдел автора
				inner join dbo.tblDept d on d.IdDept = e.IdODept
		--подцеляем текущий статус
		cross apply (
			select top 1 st.SMeasStatus, st.IdOrdr, st.IdSMeasStatuses
			from [dbo].[tSMeasStatus] sm
				inner join [dbo].[tStatuses] st on st.IdSMeasStatuses = sm.IdOStatus
			where sm.IdOSMeasPlan = smp.IdSMeas
				and isnull(sm.IdsEmp,N'') like @EmpFltr
			order by sm.DateStatus desc, sm.IdSMeasStatus
			) ls
		--тип плана
		inner join [dbo].[tSMeasType] smt on smt.IdSMeasType = smp.IdOSMeasType
		--входящий номер
		inner join [dbo].[tblDocIn] di on di.IdDocIn = smp.IdODocIn
	where e.IdEmployee = isnull(@IdEmp, e.IdEmployee) --Фильтр по автору
		and e.IdODept = isnull(@IdDept, e.IdODept)		--по отделу
		and smp.IdODocIn = isnull(@IdDocIn, smp.IdODocIn)--по вхдящему
		and ls.SMeasStatus between 2 and 6 + @ViewClosed --ограничение статусов

end