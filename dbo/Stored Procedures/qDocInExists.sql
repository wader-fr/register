-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInExists]
--DECLARE
	@NumOut varchar(50)
	--,@Year varchar(4)
	--,@DateDoc datetime = NULL
AS
BEGIN

	SET NOCOUNT ON;

	SET @NumOut = dbo.fnFindIndex(@NumOut, '')
	print @NumOut
	SELECT '№ ' + di.NumOut + ' от ' + ISNULL(CONVERT(varchar(10), di.DateOut, 104),'n/a') + ' (вх. № ' + CONVERT(varchar(15), di.NumIn) + ' от ' + CONVERT(varchar(10), di.DateIn, 104) + ')' +
		', объект: ' + ISNULL(c.sName, 'n/a') num
	FROM dbo.tblDocIn di
			LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOObject
	WHERE dbo.fnFindIndex(di.NumOut, '') = @NumOut
			AND di.DateIn >= DATEADD(YY, -2, GETDATE())

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExists] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExists] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInExists] TO [Admin]
    AS [dbo];

