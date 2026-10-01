CREATE TABLE [dbo].[tblSpecGroupWorkType] (
    [IdSpecGroupWorkType] INT IDENTITY (1, 1) NOT NULL,
    [IdOWorkType]         INT NULL,
    [IdOGroupWorkType]    INT NULL,
    CONSTRAINT [PK_tblSpecGroupWorkType] PRIMARY KEY CLUSTERED ([IdSpecGroupWorkType] ASC),
    CONSTRAINT [FK_tblSpecGroupWorkType_tblGroupWorkType] FOREIGN KEY ([IdOGroupWorkType]) REFERENCES [dbo].[tblGroupWorkType] ([IdGroupWorkType]),
    CONSTRAINT [FK_tblSpecGroupWorkType_tblSpecGroupWorkType] FOREIGN KEY ([IdOWorkType]) REFERENCES [dbo].[tblWorkType] ([IdWorkType])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSpecGroupWorkType]
    ON [dbo].[tblSpecGroupWorkType]([IdOWorkType] ASC, [IdOGroupWorkType] ASC);

