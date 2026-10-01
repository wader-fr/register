-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountDept]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int
	declare @IdFil int

	select @IdFil = d.IdOFilial
	from dbo.tblEmployee e 
		inner join dbo.tblDept d on d.IdDept = e.IdODept
	where e.lgn = SYSTEM_USER


	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblDept d
	WHERE d.Act = 1
	  AND (
			@IdFil is null
			OR d.IdOFilial = @IdFil
		  )

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnCountDept] TO PUBLIC
    AS [dbo];

