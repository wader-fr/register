CREATE TABLE [dbo].[tblBudget] (
    [IdBudget] TINYINT     IDENTITY (1, 1) NOT NULL,
    [Budget]   VARCHAR (5) NULL,
    CONSTRAINT [PK_tblBudget] PRIMARY KEY CLUSTERED ([IdBudget] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblBudget] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblBudget] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblBudget] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblBudget] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblBudget] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblBudget] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblBudget] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblBudget] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblBudget] TO [Admin]
    AS [dbo];

