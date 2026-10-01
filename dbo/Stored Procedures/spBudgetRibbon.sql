CREATE   PROCEDURE dbo.spBudgetRibbon
as
begin
	set nocount on;

	select
		0 Pos,
		0 Id,
		N'<Все>' Label

		union all

	select ROW_NUMBER() over(order by b.[IdBudget]) pos,
		b.IdBudget,
		b.Budget
	from [dbo].[tblBudget] b
			

end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spBudgetRibbon] TO PUBLIC
    AS [dbo];

