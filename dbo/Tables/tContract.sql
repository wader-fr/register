CREATE TABLE [dbo].[tContract] (
    [IdContract]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [NumContract]   NVARCHAR (20)  NULL,
    [DateContract]  DATETIME       NULL,
    [ScanContract]  NVARCHAR (250) NULL,
    [IdOContragent] BIGINT         NULL,
    CONSTRAINT [PK_tContract] PRIMARY KEY CLUSTERED ([IdContract] ASC),
    CONSTRAINT [FK_tContract_tblContragent] FOREIGN KEY ([IdOContragent]) REFERENCES [dbo].[tblContragent] ([IdContragent])
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tContract] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tContract] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tContract] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [Boss]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tContract] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tContract] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tContract] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tContract] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tContract] TO [RegistrarM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tContract] TO [RegistrarB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tContract] TO [Admin]
    AS [dbo];

