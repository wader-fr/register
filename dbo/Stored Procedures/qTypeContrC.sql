
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qTypeContrC]
AS
BEGIN
  SET NOCOUNT ON;


	IF IS_MEMBER('Admin') = 1
    SELECT
      *
    FROM dbo.tblTypeContr tc;
  ELSE
    SELECT
      *
    FROM dbo.tblTypeContr tc
    WHERE tc.IdTypeContr <> 1;
END;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeContrC] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeContrC] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeContrC] TO [Admin]
    AS [dbo];

