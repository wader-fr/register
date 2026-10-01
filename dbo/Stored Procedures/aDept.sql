-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aDept]
	@fName varchar(150) = NULL
	,@sName varchar(10) = NULL OUT
	,@IdFilial int = NULL
	,@PIdDept int = NULL
	,@IdDept int OUT
AS
BEGIN

	SET NOCOUNT ON;

	SET @fName = dbo.fnStrNorm(@fName, 0, 1)

	IF @sName IS NULL
		SET @sName = dbo.fnAbbr(@fName)

	INSERT INTO dbo.tblDept (NameDept, sNameDept, IdOFilial, PIdDept, Act)
	VALUES( @fName, @sName, @IdFilial, @PIdDept, 0)

	SET @IdDept = @@IDENTITY

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aDept] TO [Admin]
    AS [dbo];

