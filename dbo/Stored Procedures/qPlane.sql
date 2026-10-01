
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
