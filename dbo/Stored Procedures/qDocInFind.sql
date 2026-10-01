-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInFind]
--	DECLARE
	@NumIn varchar(10) = null
	,@Date datetime = null
AS
BEGIN
	DECLARE @IdEmp nvarchar(5) 

	select @IdEmp = e.IdEmployee from [dbo].[tblEmployee] e where CHARINDEX('Sampler', e.Roles) = 0 and e.lgn = USER_NAME()

	SET NOCOUNT ON;

	DECLARE @NumInS varchar(10)

	SET @NumInS = @NumIn
	SET @NumInS = REPLACE(@NumInS, '"', '');
    SET @NumInS = REPLACE(@NumInS, '-', '')
    SET @NumInS = REPLACE(@NumInS, ',', '')
    SET @NumInS = REPLACE(@NumInS, '\', '')
    SET @NumInS = REPLACE(@NumInS, '/', '')
    SET @NumInS = REPLACE(@NumInS, '''', '')
    SET @NumInS = REPLACE(@NumInS, '.', '')
    SET @NumInS = REPLACE(@NumInS, ' ', '')
	

	SELECT di.IdDocIn
			,isnull(dt.DocType, '') + ', вх. № ' + CONVERT(varchar(10),di.NumIn) + '-' + di.Suffics + ' от ' + CONVERT(varchar(10), di.DateIn, 104) +', ' + coalesce(di.[Object], c.sName, 'нет объекта') 
			--,a.IdAppointment, a.IdsEmp
	FROM dbo.tblDocIn di
			LEFT OUTER JOIN dbo.tblDocType dt ON di.IdOTypeDoc = dt.IdDocType
			LEFT OUTER JOIN dbo.tblWorkType wt ON di.IdOTypeWork = wt.IdWorkType
			LEFT OUTER JOIN dbo.tblContragent c ON di.IdOObject = c.IdContragent
			left outer join [dbo].[tAppointment] a on a.IdODoc = di.IdDocIn and a.IdOTypeApp = 2 and charindex(' ' + @IdEmp + ' ', a.IdsEmp)>0
	WHERE (CONVERT(varchar(10),di.NumIn) = @NumIn
			OR  CONVERT(varchar(10), di.NumIn) + di.Suffics = @NumInS)
			AND YEAR(di.DateIn) > = YEAR(@Date) - 4
			and a.IdAppointment is null
	ORDER BY di.DateIn DESC

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInFind] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInFind] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInFind] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInFind] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInFind] TO [Admin]
    AS [dbo];

