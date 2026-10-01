CREATE TABLE [dbo].[tProtocol] (
    [IdProt]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [NumProt]   NVARCHAR (255) NOT NULL,
    [DateProt]  DATETIME       NOT NULL,
    [Attestat]  NVARCHAR (20)  NOT NULL,
    [IdODocOut] BIGINT         NOT NULL,
    CONSTRAINT [PK_tProtocol] PRIMARY KEY CLUSTERED ([IdProt] ASC),
    CONSTRAINT [FK_tProtocol_tDocOut] FOREIGN KEY ([Attestat]) REFERENCES [dbo].[tAttestatTLC] ([AttestatTLC]) ON DELETE CASCADE,
    CONSTRAINT [FK_tProtocol_tDocOut1] FOREIGN KEY ([IdODocOut]) REFERENCES [dbo].[tDocOut] ([IdDocOut])
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tProtocol] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tProtocol] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tProtocol] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tProtocol] TO [SenderFGIS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tProtocol] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tProtocol] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tProtocol] TO [Admin]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[tProtocol] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tProtocol] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tProtocol] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tProtocol] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tProtocol] TO [Sampler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tProtocol] TO [Expert]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tProtocol] TO [Admin]
    AS [dbo];

