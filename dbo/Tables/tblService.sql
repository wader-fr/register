CREATE TABLE [dbo].[tblService] (
    [IdService]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [NameService] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_tblService] PRIMARY KEY CLUSTERED ([IdService] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblService] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblService] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblService] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblService] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblService] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblService] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblService] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblService] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblService] TO [Admin]
    AS [dbo];

