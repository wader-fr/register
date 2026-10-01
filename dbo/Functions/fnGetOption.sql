-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetOption]
(
	@NameOpt varchar(50)
)
RETURNS nvarchar(max)
AS
BEGIN

	DECLARE @Result nvarchar(max)

	SELECT @Result = o.Optn
	FROM dbo.tblOption o
	WHERE o.Name_Option = @NameOpt

	RETURN @Result

END
