CREATE PROCEDURE [dbo].[qObjectRep]
	@IdDocIn BIGINT
AS
BEGIN

  SET NOCOUNT ON;

  SELECT
    o.IdObject
   ,ISNULL(o.NameObject, 'Не указано')
   ,ISNULL(o.pAddress, 'Без адреса')
   ,dbo.fnInitial(e.LastName + ' ' + e.FirstName + ' ' + e.Patronimic) emp
   ,d.sNameDept
   ,o.DateCont
   ,o.DateEnd
  FROM dbo.tblObject o
		LEFT OUTER JOIN dbo.tblDept d ON d.IdDept = o.IdODept
		LEFT OUTER JOIN dbo.tblEmployee e ON e.IdEmployee = o.IdOEmp
  WHERE (o.IdODocIn = @IdDocIn);

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qObjectRep] TO [RegistrarM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qObjectRep] TO [RegistrarB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qObjectRep] TO [Admin]
    AS [dbo];

