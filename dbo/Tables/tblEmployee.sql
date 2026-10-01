CREATE TABLE [dbo].[tblEmployee] (
    [IdEmployee] INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]  NVARCHAR (50)  NOT NULL,
    [Patronimic] NVARCHAR (50)  NOT NULL,
    [LastName]   NVARCHAR (50)  NOT NULL,
    [IdODept]    INT            NOT NULL,
    [IdOPost]    INT            NULL,
    [lgn]        VARCHAR (20)   NULL,
    [Fired]      BIT            CONSTRAINT [DF_tblEmployee_Fired] DEFAULT ((0)) NOT NULL,
    [FullName]   AS             ((((([LastName]+' ')+left([FirstName],(1)))+'. ')+left([Patronimic],(1)))+'.'),
    [Roles]      NVARCHAR (500) NULL,
    CONSTRAINT [PK_tblEmployee] PRIMARY KEY CLUSTERED ([IdEmployee] ASC),
    CONSTRAINT [FK_tblEmployee_tblDept] FOREIGN KEY ([IdODept]) REFERENCES [dbo].[tblDept] ([IdDept]),
    CONSTRAINT [FK_tblEmployee_tblPost] FOREIGN KEY ([IdOPost]) REFERENCES [dbo].[tblPost] ([IdPost])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEmployee]
    ON [dbo].[tblEmployee]([lgn] ASC);

