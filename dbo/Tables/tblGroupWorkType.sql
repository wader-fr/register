CREATE TABLE [dbo].[tblGroupWorkType] (
    [IdGroupWorkType] INT          IDENTITY (1, 1) NOT NULL,
    [GroupWorkType]   VARCHAR (20) NULL,
    CONSTRAINT [PK_tblGroupWorkType] PRIMARY KEY CLUSTERED ([IdGroupWorkType] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Sampler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Expert]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Sampler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Expert]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Expert]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Expert]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblGroupWorkType] TO [Admin]
    AS [dbo];

