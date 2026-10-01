CREATE FUNCTION fnTypePlanIdR
(
	@pos int
)
RETURNS int
AS
BEGIN
	
	DECLARE @Result int
	DECLARE @tbl table(pos int, IdSMeasType int)
	

	insert into @tbl
	values (0, 0)

	insert into @tbl
	select ROW_NUMBER() over (order by IdSMeasType) pos, smt.IdSMeasType
	from [dbo].[tSMeasType] smt

	select @Result = IdSMeasType
	from @tbl
	where pos = @pos

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnTypePlanIdR] TO PUBLIC
    AS [dbo];

