create procedure dbo.[qSMeasTypeC]
as
	begin

	set nocount on;

	select smt.IdSMeasType, smt.sMeasType from dbo.tSMeasType smt

	end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSMeasTypeC] TO PUBLIC
    AS [dbo];

