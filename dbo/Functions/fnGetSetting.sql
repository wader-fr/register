-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetSetting]
(
	@Id int
)
RETURNS nvarchar(max)
AS
BEGIN

	DECLARE @Result nvarchar(max)

	SELECT @Result = o.Optn
	FROM dbo.tblOption o
	WHERE o.IdOption = @Id

	RETURN @Result

END
