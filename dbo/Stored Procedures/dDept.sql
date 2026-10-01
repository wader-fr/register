-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[dDept]
	@IdDept int
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRAN
		IF EXISTS (SELECT * FROM dbo.tblEmployee e WHERE e.IdODept = @IdDept)
			BEGIN
				RAISERROR('Нельзя удалить - есть сотрудники!', 16, 1)
				ROLLBACK TRAN
			END
		ELSE IF EXISTS(SELECT * FROM dbo.tblDept d WHERE d.PIdDept = @IdDept)
			BEGIN
				RAISERROR('Нелзя удалить - есть подчиненные!', 16, 1)
				ROLLBACK TRAN
			END
		ELSE 
			DELETE FROM dbo.tblDept
			WHERE IdDept = @IdDept
			COMMIT TRAN
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[dDept] TO [Admin]
    AS [dbo];

