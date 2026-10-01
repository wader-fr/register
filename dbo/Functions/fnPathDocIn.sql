CREATE FUNCTION [dbo].[fnPathDocIn]
(
	@id bigint
)
RETURNS varchar(max)
AS
BEGIN

	DECLARE @Result varchar(max)
	DECLARE @Path varchar(max)
	SET @Path = [dbo].[fnGetSetting](1) 


	SELECT @Result = @Path + '\' + IsNull(di.ScanDocIn, convert(varchar(4),di.YearDoc) + '\' + CONVERT(varchar(10),di.NumIn)+ '-' + di.Suffics + '\0')  FROM tblDocIn di WHERE di.IdDocIn = @id

	RETURN @Result

END
