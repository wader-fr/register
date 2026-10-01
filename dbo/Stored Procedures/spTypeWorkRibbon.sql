CREATE   PROCEDURE dbo.spTypeWorkRibbon
as
begin
	set nocount on;

	select
		0 Pos,
		0 Id,
		N'<Все>' Label

		union all

	select ROW_NUMBER() over(order by wt.[IdWorkType]) pos,
		wt.IdWorkType,
		wt.WorkType
	from dbo.tblWorkType wt
			

end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spTypeWorkRibbon] TO PUBLIC
    AS [dbo];

