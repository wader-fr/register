CREATE TABLE [dbo].[tblSpecGroupDocType] (
    [IdSpecGroupDocType] INT IDENTITY (1, 1) NOT NULL,
    [IdODocType]         INT NULL,
    [IdOGroupDocType]    INT NULL,
    CONSTRAINT [PK_tblSpecGroupDocType] PRIMARY KEY CLUSTERED ([IdSpecGroupDocType] ASC),
    CONSTRAINT [FK_tblSpecGroupDocType_tblGroupDocType] FOREIGN KEY ([IdOGroupDocType]) REFERENCES [dbo].[tblGroupDocType] ([IdGroupDocType]),
    CONSTRAINT [FK_tblSpecGroupDocType_tblSpecGroupDocType] FOREIGN KEY ([IdODocType]) REFERENCES [dbo].[tblDocType] ([IdDocType])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSpecGroupDocType]
    ON [dbo].[tblSpecGroupDocType]([IdODocType] ASC, [IdOGroupDocType] ASC);

