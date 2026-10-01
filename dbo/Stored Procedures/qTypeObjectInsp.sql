CREATE PROCEDURE [dbo].[qTypeObjectInsp]
AS 
  SELECT toi.IdTypeObjectInsp, toi.TypeObjectInsp
  FROM tTypeObjectInsp toi
  ORDER BY toi.IdTypeObjectInsp
