CREATE TABLE [dbo].[tIndex] (
    [IdIndex]   INT            IDENTITY (1, 1) NOT NULL,
    [NameIndex] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tIndex] PRIMARY KEY CLUSTERED ([IdIndex] ASC)
);

