-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.fnTypePlanSR
(
	@pos nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	
	DECLARE @Result nvarchar(50)
	DECLARE @tbl table(pos int, SMeasType nvarchar(50))
	

	insert into @tbl
	values (0, '<Все>')

	insert into @tbl
	select ROW_NUMBER() over (order by IdSMeasType) pos, smt.SMeasType
	from [dbo].[tSMeasType] smt

	select @Result = SMeasType
	from @tbl
	where pos = @pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnTypePlanSR] TO PUBLIC
    AS [dbo];

