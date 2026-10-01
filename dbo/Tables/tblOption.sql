CREATE TABLE [dbo].[tblOption] (
    [IdOption]    INT            NULL,
    [Name_Option] VARCHAR (50)   NULL,
    [Optn]        NVARCHAR (MAX) NULL
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblOption] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblOption] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblOption] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblOption] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblOption] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblOption] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblOption] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblOption] TO [Admin]
    AS [dbo];

