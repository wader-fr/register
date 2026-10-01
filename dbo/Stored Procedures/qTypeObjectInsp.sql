CREATE PROCEDURE [dbo].[qTypeObjectInsp]
AS 
  SELECT toi.IdTypeObjectInsp, toi.TypeObjectInsp
  FROM tTypeObjectInsp toi
  ORDER BY toi.IdTypeObjectInsp
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjectInsp] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qTypeObjectInsp] TO [Admin]
    AS [dbo];

