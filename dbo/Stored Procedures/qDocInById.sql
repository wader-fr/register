-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].qDocInById 
--	DECLARE
		@Id bigint
AS
BEGIN

	SET NOCOUNT ON;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SELECT di.IdDocIn, di.NumInA, di.DateIn, di.NumOut, di.DateOut, di.NoEx, di.YearDoc, di.NumCancel, di.DateCancel, di.NumCancelOut, di.DateCancelOut ,di.ScanDocIn, di.NumInsp + N' от ' + CONVERT (NVARCHAR, di.DateInsp, 4) Inspection,
		di.DatePlane, di.DateEnd,
		CONVERT (NVARCHAR, di.NumIn) + N'-' + di.Suffics NumInF, 
		CASE WHEN ISNULL(att.c, 0) > 0 THEN 1 ELSE 0 END AttachC,
		CASE WHEN ISNULL(s.c, 0) > 0 THEN 1 ELSE 0 END SubDocC, 
		CASE WHEN ISNULL(sc.c, 0) > 0 THEN 1 ELSE 0 END ScanC, 
		a1.Depts Embed, a1.IdsDept,	a2.Depts Accepted,
		case when c.sName is not null then isnull(pc.Property, '') + ' ' + c.sName else c.fName end Contragent, 
	
		isnull(di.[Object],case when obj.sName is not null then isnull(p.Property, '') + ' ' + obj.sName else obj.fName end)[object] ,
		dt.sDocType, wt.WorkType,
		ct.NumContract + ' от ' + CONVERT(varchar(10), ct.DateContract, 104) NumContract
--
	FROM dbo.tblDocIn di
		LEFT OUTER JOIN dbo.ftAppointment(1) a1 ON a1.IdODoc = di.IdDocIn
		LEFT OUTER JOIN dbo.ftAppointment(2) a2 ON a2.IdODoc = di.IdDocIn
		LEFT OUTER JOIN dbo.tblContragent c ON c.IdContragent = di.IdOContragent
		LEFT OUTER JOIN dbo.tblContragent obj ON obj.IdContragent = di.IdOObject
		left outer join [dbo].[tblProp] p on p.IdProperty = obj.IdOProperty
		left outer join [dbo].[tblProp] pc on pc.IdProperty = c.IdOProperty
		LEFT OUTER JOIN dbo.tblDocType dt ON dt.IdDocType = di.IdOTypeDoc
		LEFT OUTER JOIN dbo.tblWorkType wt ON wt.IdWorkType = di.IdOTypeWork
		LEFT OUTER JOIN [dbo].[tContract] ct ON ct.IdContract = di.IdOContract
		LEFT OUTER JOIN (SELECT COUNT(a.IdAttach) c, a.IdODocIn FROM dbo.tAttach a GROUP BY a.IdODocIn) att ON att.IdODocIn = di.IdDocIn
		LEFT OUTER JOIN (SELECT COUNT(sdi.IdSubDocIn) c, sdi.IdODocIn FROM dbo.tSubDocIn sdi GROUP BY sdi.IdODocIn) s ON s.IdODocIn = di.IdDocIn
		LEFT OUTER JOIN (SELECT COUNT(sdi.IdScanIn) c, sdi.IdODocIn FROM dbo.tScanDocIn sdi GROUP BY sdi.IdODocIn) sc ON sc.IdODocIn = di.IdDocIn

	WHERE di.IdDocIn = @Id
	
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInById] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInById] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInById] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInById] TO [Admin]
    AS [dbo];

