
CREATE function [dbo].[fnGetPathDoc]
(

	@IdDocIn bigint
)
returns nvarchar(max)
as
begin
	declare @Ret nvarchar(max)

	declare @Path nvarchar(1024) = [dbo].[fnGetOption]('PathPred')

	select @Ret = [dbo].[fnBuildPath](@Path, di.YearDoc, di.NumInS,null)
	from [dbo].[tblDocIn] di
	where di.IdDocIn = @IdDocIn
	
	return @ret
end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnGetPathDoc] TO PUBLIC
    AS [dbo];

