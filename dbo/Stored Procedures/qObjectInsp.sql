CREATE PROCEDURE [dbo].[qObjectInsp]
  @IdType INT = NULL
  ,@ObjectIndp NVARCHAR(250) = NULL
AS 

  SET @ObjectIndp = dbo.fnFindIndex(@ObjectIndp,'%')

  SELECT oi.IdObjectInsp, oi.ObjectInsp, oi.IdOTypeObject
  FROM dbo.tObjectInsp oi
  WHERE oi.IdOTypeObject = ISNULL(@IdType, oi.IdOTypeObject)
        AND oi.ObjectInsp LIKE @ObjectIndp
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qObjectInsp] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qObjectInsp] TO [Admin]
    AS [dbo];

