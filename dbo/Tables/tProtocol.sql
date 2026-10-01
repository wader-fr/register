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

