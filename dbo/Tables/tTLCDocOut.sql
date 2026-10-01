CREATE TABLE [dbo].[tTLCDocOut] (
    [IdTLCDocOut] INT    IDENTITY (1, 1) NOT NULL,
    [IdODocOut]   BIGINT NOT NULL,
    [IdOEmp]      INT    NOT NULL,
    [IdOProtocol] BIGINT NOT NULL,
    CONSTRAINT [PK_tTLCDocOut] PRIMARY KEY CLUSTERED ([IdTLCDocOut] ASC),
    CONSTRAINT [FK_tTLCDocOut_tProtocol] FOREIGN KEY ([IdOProtocol]) REFERENCES [dbo].[tProtocol] ([IdProt]) ON DELETE CASCADE,
    CONSTRAINT [FK_tTLCDocOut_tTLCEmp] FOREIGN KEY ([IdOEmp]) REFERENCES [dbo].[tTLCEmp] ([IdTLCEmp])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tTLCDocOut]
    ON [dbo].[tTLCDocOut]([IdODocOut] ASC, [IdOEmp] ASC, [IdOProtocol] ASC);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTLCDocOut] TO [SenderFGIS]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tTLCDocOut] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Sampler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Expert]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tTLCDocOut] TO [Admin]
    AS [dbo];

