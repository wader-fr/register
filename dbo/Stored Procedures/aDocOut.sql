-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aDocOut]
	@Suffics char(2)
	,@Year nchar(4)
	,@Emp  int
	,@DocIn bigint
	,@TypeDocOut int
	,@DateDocOut datetime
	,@Dept int
	,@OutAA bit
	,@Return_value bigint out
	
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.tDocOut (Suffics, YearOut, IdOEmp, IdODocIn, IdOTypeDocOut, DateDocOut, IdODept, OutAA)
	VALUES(@Suffics, @Year, @Emp, @DocIn, @TypeDocOut, @DateDocOut, @Dept, @OutAA)

	SET @Return_value = @@IDENTITY

END
