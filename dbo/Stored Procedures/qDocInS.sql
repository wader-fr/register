-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qDocInS]
--	declare
	@id int = 79070
AS
begin

	SET NOCOUNT ON;

	declare @TypeDoc varchar(150)
	declare @Con varchar(50), @Obj varchar(50)
	declare @IdsDept as varchar(255), @Depts varchar(500)
	declare @Path nvarchar(max) = dbo.fnGetPathDoc(@id)

	select @TypeDoc = dt.sDocType
	from [dbo].[tblDocType] dt
		inner join [dbo].[tblDocIn] di on di.IdOTypeDoc = dt.IdDocType
	where di.IdDocIn = @id

	select @IdsDept = a.IdsDept, @Depts = a.Depts FROM tAppointment a WHERE a.IdODoc = @Id AND a.IdOTypeApp = 1

	select @Con = c.sName, @Obj = isnull(o.sName,o.fName)
	from dbo.tblDocIn di
		left outer join dbo.tblContragent c on c.IdContragent = di.IdOContragent
		left outer join dbo.tblContragent o on o.IdContragent = di.IdOObject
	where di.IdDocIn = @id


	select di.IdDocIn
	,di.DateIn
	,di.NumOut
	,di.DateOut
	,di.YearDoc
	,di.NumInsp
	,di.DateInsp
	,di.IdOContragent
	,di.IdOObject
	,@Con Contragent
	--,@Obj [ObjectA]
	,isnull(di.[Object],@obj) [ObjectA]
	,di.[Object]
	,di.IdOTypeDoc
	,di.IdOTypeWork
	,di.NoteDoc
	,di.DatePlane
	,di.DateEnd
	,di.NumInS
	,di.NumCancel
	,di.DateCancel
	,di.NumCancelOut
	,di.DateCancelOut
	,di.NoEx
	,dbo.fnBuildPath(@Path, @TypeDoc + ' ' + di.NumInS + '.pdf', null, null) PathScan
	,di.ScanDocIn
	,@Depts Depts
	,@IdsDept IdsDept
	,di.IdOContract
	from dbo.tblDocIn di
	where di.IdDocIn = @id
end
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [Boss]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qDocInS] TO [Admin]
    AS [dbo];

