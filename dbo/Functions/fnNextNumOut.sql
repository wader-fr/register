-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnNextNumOut]
(
	@Year varchar(4)
	,@TypeDoc int
	,@Group smallint = NULL
)
RETURNS int
AS
BEGIN

	DECLARE @Result int

	IF @Group IS NULL
		BEGIN
			SELECT @Result = ISNULL(MAX(do.ANumDocOut), 0) + 1
			FROM dbo.tDocOut do
			WHERE do.YearOut = @Year
					AND do.IdOTypeDocOut = @TypeDoc
		END
	ELSE
		BEGIN
			SELECT @Result = ISNULL(MAX(do.ANumDocOut), 0) + 1
			FROM dbo.tDocOut do
					LEFT OUTER JOIN tblDocTypeOut dt ON do.IdOTypeDocOut = dt.IdDocTypeOut
			WHERE do.YearOut = @Year
					AND dt.AutoNumGroup = @Group
		END

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnNextNumOut] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[fnNextNumOut] TO [Admin]
    AS [dbo];

