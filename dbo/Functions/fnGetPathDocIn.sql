
create function [dbo].[fnGetPathDocIn]
(
	@IdDocIn bigint
)
returns nvarchar(4000)
as
begin
	declare @Ret nvarchar(4000)

	declare @Path nvarchar(4000) = [dbo].[fnGetOption]('PathScan')

	select @Ret= @Path + N'\' +di.YearDoc + N'\' +convert(nvarchar(10), di.NumIn) + N'-' + di.Suffics  from [dbo].[tblDocIn] di where di.IdDocIn = @IdDocIn

	return @Ret

end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnGetPathDocIn] TO PUBLIC
    AS [dbo];

