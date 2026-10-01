
CREATE procedure uLgn
--	declare
	@lgn nvarchar(50),
	@pass nvarchar(50)
as
begin
	set @lgn = QUOTENAME(@lgn)
	exec ('ALTER LOGIN ' + @lgn +' WITH PASSWORD=''' + @pass + '''')
end
