CREATE TABLE [dbo].[tScanDocIn] (
    [IdScanIn]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [IdODocIn]    BIGINT         NULL,
    [Description] VARCHAR (MAX)  NULL,
    [doc]         VARCHAR (1024) NULL,
    CONSTRAINT [PK_tScanDocIn] PRIMARY KEY CLUSTERED ([IdScanIn] ASC),
    CONSTRAINT [FK_tScanDocIn_tblDocIn] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);

