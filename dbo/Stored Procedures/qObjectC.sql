-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qObjectC]
--	DECLARE
	@IdDocIn int
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @tbl table (IdObject int, NameObject varchar(1000))

	INSERT INTO @tbl
	VALUES (0, '<<Добавить/редактировать>>')

	INSERT INTO @tbl
	SELECT o.IdObject
	,COALESCE(o.NameObject + ', ' + o.pAddress, o.NameObject, o.pAddress)
	FROM dbo.tblObject o
	WHERE o.IdODocIn = @IdDocIn

	SELECT * FROM @tbl

END
