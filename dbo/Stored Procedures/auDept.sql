-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[auDept]
	@IdDept int --OUT
	,@NameDept varchar(50)
	,@PIdDept int
	,@IdOFilial int
	,@IdDeptOut int OUT
	,@sNameDept varchar(10) OUT
	,@NameDeptOut varchar(50) OUT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @PosB int, @PosE int--, @sNameDept varchar(10)

	SET @NameDept = dbo.fnStrNorm(@NameDept, 0, 1)
	IF @IdDept = 0 SET @IdDept = NULL

	IF CHARINDEX('(', @NameDept, 1) >0
		BEGIN
			SET @PosB = CHARINDEX('(', @NameDept, 1)
			SET @PosE = CHARINDEX(')', @NameDept, 1)
			SET @sNameDept = RTRIM(LTRIM(SUBSTRING(@NameDept, @PosB + 1, @PosE - @PosB -1)))
			SET @NameDept = RTRIM(LEFT(@NameDept, @PosB -2))
		END

	ELSE IF @sNameDept IS NULL OR @sNameDept = ''
		SET @sNameDept = dbo.fnAbbr(@NameDept)

	IF @IdDept IS NULL OR @IdDept = 0
		BEGIN
			INSERT INTO dbo.tblDept (NameDept, sNameDept, PIdDept, IdOFilial, Act)
			VALUES (@NameDept, @sNameDept, @PIdDept, @IdOFilial, 1)
			SET @IdDeptOut = @@IDENTITY
		END
	ELSE
		BEGIN
			UPDATE dbo.tblDept
			SET NameDept = ISNULL(@NameDept, NameDept)
				,sNameDept = ISNULL(@sNameDept, sNameDept)
			FROM dbo.tblDept
			WHERE IdDept = @IdDept
			SET @IdDeptOut = @IdDept
		END

END
