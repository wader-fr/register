CREATE FUNCTION [dbo].[fnPathContract]
(
	@id bigint
)
RETURNS varchar(max)
AS
BEGIN

	DECLARE @Result varchar(max)
	DECLARE @Path varchar(max)
	SET @Path = [dbo].[fnGetSetting](1) + '\contracts'


	SELECT @Result = @Path + '\' +  c.ScanContract FROM dbo.tContract c WHERE c.IdContract = @id

	RETURN @Result

END
