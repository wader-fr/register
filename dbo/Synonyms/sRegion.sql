CREATE SYNONYM [dbo].[sRegion] FOR [kladr].[dbo].[vRegion];


GO
GRANT SELECT
    ON OBJECT::[dbo].[sRegion] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[sRegion] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[sRegion] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[sRegion] TO [Admin]
    AS [dbo];

