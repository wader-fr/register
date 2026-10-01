CREATE TABLE [dbo].[tAttestatTLC] (
    [AttestatTLC] NVARCHAR (20)  NOT NULL,
    [NameLab]     NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tAttestatTLC] PRIMARY KEY CLUSTERED ([AttestatTLC] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAttestatTLC] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAttestatTLC] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAttestatTLC] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAttestatTLC] TO [SenderFGIS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAttestatTLC] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tAttestatTLC] TO [Admin]
    AS [dbo];

