
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[uOption]
	@Name varchar(50)
	,@opt varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	
	IF EXISTS (SELECT * FROM tblOption WHERE Name_Option = @Name)
		UPDATE dbo.tblOption
		SET Optn = @opt
		WHERE Name_Option = @Name;
	ELSE
		INSERT INTO tblOption (Name_Option, Optn)
		VALUES (@Name, @opt)

END
