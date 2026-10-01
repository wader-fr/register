
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qPlane]
--	Declare
		@IdDocIn bigint
AS
BEGIN
	SET NOCOUNT ON;

	SELECT C.fName AS [<Customer>], coalesce(di.[Object], o.fName, o.sName) AS [<ObjInsp>], dt.DocType + ' вх. № ' +  di.NumInA [<NumDocIn>]
	FROM   tblDocIn AS di 
		INNER JOIN tblContragent AS C ON di.IdOContragent = C.IdContragent
		LEFT JOIN tblContragent AS o ON di.IdOObject = o.IdContragent
		INNER JOIN dbo.tblDocType dt ON di.IdOTypeDoc = dt.IdDocType
WHERE di.IdDocIn = @IdDocIn
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlane] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlane] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qPlane] TO [Admin]
    AS [dbo];

