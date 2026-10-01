
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qF13_6]
--DECLARE
	@Year VARCHAR(4)
AS
	SELECT TypeObj AS [Вид объекта],
		(SELECT COUNT(*)
		FROM dbo.vDocOutExec AS do
		WHERE do.IdOExpType = 8
			AND do.YearOut = @Year
			AND do.IdOTypeObj = tob.IdTypeObj
		) AS [Эксплуатация ПРТО],
		(SELECT COUNT(*)
		FROM dbo.vDocOutExec AS do
		WHERE do.IdOExpType = 8
			AND do.YearOut = @Year
			AND do.IdOTypeObj = tob.IdTypeObj
			AND do.IdOResult = 2
		) AS [из них о несоответствии],
		(SELECT COUNT(*)
		FROM dbo.vDocOutExec AS do
		WHERE do.IdOExpType = 13
			AND do.YearOut = @Year
			AND do.IdOTypeObj = tob.IdTypeObj
		) AS [Проект ПРТО],
		(SELECT COUNT(*)
		FROM dbo.vDocOutExec AS do
		WHERE do.IdOExpType = 13
			AND do.YearOut = @Year
			AND do.IdOTypeObj = tob.IdTypeObj
			AND do.IdOResult = 2
		) AS [из них о несоответствии]
	FROM dbo.tblTypeObj AS tob
	WHERE tob.IdTypeObj IN (61,62,63,64)

