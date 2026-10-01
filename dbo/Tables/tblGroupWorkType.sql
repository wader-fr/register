CREATE TABLE [dbo].[tblGroupWorkType] (
    [IdGroupWorkType] INT          IDENTITY (1, 1) NOT NULL,
    [GroupWorkType]   VARCHAR (20) NULL,
    CONSTRAINT [PK_tblGroupWorkType] PRIMARY KEY CLUSTERED ([IdGroupWorkType] ASC)
);

