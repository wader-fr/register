-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnCountWorkType]
(
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	SELECT @Result = COUNT(*) + 1
	FROM dbo.tblWorkType

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnCountWorkType] TO PUBLIC
    AS [dbo];

