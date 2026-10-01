CREATE TABLE [dbo].[tblGroupDocType] (
    [IdGroupDocType] INT          IDENTITY (1, 1) NOT NULL,
    [GroupDocType]   VARCHAR (20) NULL,
    CONSTRAINT [PK_tblGroupDocType] PRIMARY KEY CLUSTERED ([IdGroupDocType] ASC)
);

