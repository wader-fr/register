-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aDocIn]
	@Year char(4)
	,@DateIn datetime
	,@NumOut varchar(50) = NULL
	,@suffics varchar(2)
	,@Return_value int OUT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @NumIn int

	SET @NumIn = dbo.fnNextNumIn(@Year)
	SET @NumOut = dbo.fnStrNorm(@NumOut, 1, 1)

	INSERT INTO dbo.tblDocIn (NumIn, DateIn, NumOut, YearDoc, Suffics)
	VALUES (@NumIn, ISNULL(@DateIn, GETDATE()), @NumOut, @Year, @suffics)

	SET @Return_value = @@IDENTITY
	
END
