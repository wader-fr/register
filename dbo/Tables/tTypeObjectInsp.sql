CREATE TABLE [dbo].[tTypeObjectInsp] (
    [IdTypeObjectInsp] INT           IDENTITY (1, 1) NOT NULL,
    [TypeObjectInsp]   VARCHAR (150) NULL,
    CONSTRAINT [PK_tTypeObjectInsp_IdTypeObjectInsp] PRIMARY KEY CLUSTERED ([IdTypeObjectInsp] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [SenderFGIS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tTypeObjectInsp] TO [Admin]
    AS [dbo];

