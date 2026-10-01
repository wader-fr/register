
CREATE procedure [dbo].[qGetPathDocIn]
--declare
	@IdDocIn bigint = 79070
as

set nocount on

declare @Path nvarchar(4000) = [dbo].[fnGetOption]('PathScan')

select @Path + N'\' +di.YearDoc + N'\' +convert(nvarchar(10), di.NumIn) + N'-' + di.Suffics pathScan from [dbo].[tblDocIn] di where di.IdDocIn = @IdDocIn
