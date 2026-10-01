CREATE TABLE [dbo].[tScanDocIn] (
    [IdScanIn]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [IdODocIn]    BIGINT         NULL,
    [Description] VARCHAR (MAX)  NULL,
    [doc]         VARCHAR (1024) NULL,
    CONSTRAINT [PK_tScanDocIn] PRIMARY KEY CLUSTERED ([IdScanIn] ASC),
    CONSTRAINT [FK_tScanDocIn_tblDocIn] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tScanDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tScanDocIn] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [Boss]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tScanDocIn] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tScanDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tScanDocIn] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tScanDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tScanDocIn] TO [Admin]
    AS [dbo];

