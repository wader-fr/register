CREATE PROCEDURE [dbo].[qAttachS]
--	DECLARE
	@IdDocIn bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @Path nvarchar(512) = [dbo].[fnGetOption]('PathScan')

	select @Path = @Path + '\' + di.YearDoc + '\' + convert(nvarchar(10), di.NumIn) + '-' + di.Suffics + '\' from dbo.tblDocIn di where di.IdDocIn = @IdDocIn

	SELECT a.IdAttach, a.NameAttach, a.NumAttach, a.NameAttach + '.pdf' scan, @Path + a.NameAttach  + '.pdf' PathAttach, a.IdODocIn
	FROM dbo.tAttach a
	WHERE a.IdODocIn = @IdDocIn

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qAttachS] TO [Admin]
    AS [dbo];

