CREATE TABLE [dbo].[tblEmployee] (
    [IdEmployee] INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]  NVARCHAR (50)  NOT NULL,
    [Patronimic] NVARCHAR (50)  NOT NULL,
    [LastName]   NVARCHAR (50)  NOT NULL,
    [IdODept]    INT            NOT NULL,
    [Post]       VARCHAR (150)  NULL,
    [lgn]        VARCHAR (20)   NULL,
    [Fired]      BIT            CONSTRAINT [DF_tblEmployee_Fired] DEFAULT ((0)) NOT NULL,
    [FullName]   AS             ((((([LastName]+' ')+left([FirstName],(1)))+'. ')+left([Patronimic],(1)))+'.'),
    [Roles]      NVARCHAR (500) NULL,
    CONSTRAINT [PK_tblEmployee] PRIMARY KEY CLUSTERED ([IdEmployee] ASC),
    CONSTRAINT [FK_tblEmployee_tblDept] FOREIGN KEY ([IdODept]) REFERENCES [dbo].[tblDept] ([IdDept])
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEmployee]
    ON [dbo].[tblEmployee]([lgn] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_tblEmployee_lgn]
    ON [dbo].[tblEmployee]([lgn] ASC)
    INCLUDE([IdODept]);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblEmployee] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblEmployee] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblEmployee] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblEmployee] TO [Admin]
    AS [dbo];

