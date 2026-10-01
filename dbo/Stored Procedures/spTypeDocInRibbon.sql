CREATE   PROCEDURE dbo.spTypeDocInRibbon
as
begin
	set nocount on;

	select
		0 Pos,
		0 IdType,
		N'<Все>' TypeDoc

		union all

	select ROW_NUMBER() over(order by dt.[Ordr]) pos,
		dt.[IdDocType],
		dt.DocType
	from [dbo].[tblDocType] dt
	where dt.Act = 1


		

end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spTypeDocInRibbon] TO PUBLIC
    AS [dbo];

