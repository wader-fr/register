CREATE TABLE [dbo].[tblBudget] (
    [IdBudget] TINYINT     IDENTITY (1, 1) NOT NULL,
    [Budget]   VARCHAR (5) NULL,
    CONSTRAINT [PK_tblBudget] PRIMARY KEY CLUSTERED ([IdBudget] ASC)
);

