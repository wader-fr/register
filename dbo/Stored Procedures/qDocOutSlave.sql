-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocOutSlave]
	@DocIn bigint
AS
BEGIN

	SET NOCOUNT ON;

	SELECT do.IdDocOut
		, do.NumDocOut + '-' + do.Suffics num
		, dto.DocTypeOut
		, do.DateDocOut
		, o.DateEnd
		, COALESCE(o.NameObject + ', ' + o.pAddress, o.NameObject, o.pAddress) obj
		, e.LastName
		, d.sNameDept
	FROM dbo.tDocOut do
			LEFT OUTER JOIN dbo.tblObject o ON do.IdOObject = o.IdObject
			INNER JOIN dbo.tblDocTypeOut dto ON do.IdOTypeDocOut = dto.IdDocTypeOut
			LEFT OUTER JOIN dbo.tblEmployee e ON e.IdEmployee = do.IdOEmp
			LEFT OUTER JOIN dbo.tblDept d ON d.IdDept = do.IdODept
	WHERE do.IdODocIn = @DocIn

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocOutSlave] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocOutSlave] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocOutSlave] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocOutSlave] TO [Admin]
    AS [dbo];

