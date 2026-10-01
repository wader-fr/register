-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aDocOutN]
--	declare
	@Suffics char(2) = 'ЦА'
	,@Year nchar(4) = '2026'
	,@IdEmp  nvarchar(5) = '54'
	,@DocIn bigint = 82268
	,@TypeDocOut int = 17
	,@DateDocOut datetime = '2026-03-03'
	,@OutAA bit = 0
	,@DocCount int = 2
	,@IdDoc nvarchar(200) = '' out
AS
BEGIN
	SET NOCOUNT ON;

	declare @Count integer = 0;
	declare @IdsDepts nvarchar(1000)
			,@IdsEmp nvarchar(1000)
			,@IdDept nvarchar(5)

	select @IdDept = e.IdODept from [dbo].[tblEmployee] e where e.IdEmployee = @IdEmp

-- Если сотрудник не ИЛЦ, то создаем этапы
	if exists(select * from [dbo].[tblEmployee] e where e.IdEmployee  = @idEmp and CHARINDEX('Sampler', e.Roles) = 0)
		begin
			--Если нет 1 этапа, надо его создать
			if not exists(select * from [dbo].[tAppointment] a where a.IdODoc = @DocIn and a.IdOTypeApp = 1 and CHARINDEX(@IdDept, a.IdsDept) > 0)
				begin
					set @IdsDepts = dbo.fnDepts(@DocIn) + @IdDept + ' '
					exec [dbo].[u1Etap] @IdDoc = @DocIn, @IdsDept = @IdsDepts
				end


			--Если нет 2 этапа, надо его создать
			if not exists(select * from [dbo].[tAppointment] a where a.IdODoc = @DocIn and a.IdOTypeApp = 2  and CHARINDEX(@IdEmp, a.IdsEmp) > 0)
				begin
					set @IdsEmp = dbo.fnEmps(@DocIn) + @IdEmp + ' '
					exec [dbo].[u2Etap] @IdDoc = @DocIn, @IdsEmp = @IdsEmp
				end

			--Если нет 3 этапа, надо его создать
			if not exists(select * from [dbo].[tAppointment] a where a.IdODoc = @DocIn and a.IdOTypeApp = 3  and CHARINDEX(@IdEmp, a.IdsEmp) > 0)
				begin
					exec [dbo].[u3Etap] @IdDoc = @DocIn
				end

			--Если нет 4 этапа, надо его создать
			if not exists(select * from [dbo].[tAppointment] a where a.IdODoc = @DocIn and a.IdOTypeApp = 4  and CHARINDEX(@IdEmp, a.IdsEmp) > 0)
				begin
					exec [dbo].[u4Etap] @IdDoc = @DocIn
				end
		end

	while @Count < @DocCount
		begin

			INSERT INTO dbo.tDocOut (Suffics, YearOut, IdOEmp, IdODocIn, IdOTypeDocOut, DateDocOut, IdODept, OutAA)
			VALUES(@Suffics, @Year, @IdEmp, @DocIn, @TypeDocOut, @DateDocOut, @IdDept, @OutAA)
			set @IdDoc = @@IDENTITY
			set @Count = @Count + 1
		end

	if @DocCount > 1
		set @IdDoc = 0


END
