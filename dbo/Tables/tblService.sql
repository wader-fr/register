CREATE TABLE [dbo].[tblService] (
    [IdService]   TINYINT      IDENTITY (1, 1) NOT NULL,
    [NameService] VARCHAR (10) NOT NULL,
    CONSTRAINT [PK_tblService] PRIMARY KEY CLUSTERED ([IdService] ASC)
);

