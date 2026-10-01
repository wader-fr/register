CREATE TABLE [dbo].[tblGroupDocType] (
    [IdGroupDocType] INT          IDENTITY (1, 1) NOT NULL,
    [GroupDocType]   VARCHAR (20) NULL,
    CONSTRAINT [PK_tblGroupDocType] PRIMARY KEY CLUSTERED ([IdGroupDocType] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupDocType] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupDocType] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupDocType] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupDocType] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupDocType] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupDocType] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupDocType] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarM]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupDocType] TO [RegistrarB]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupDocType] TO [Admin]
    AS [dbo];

