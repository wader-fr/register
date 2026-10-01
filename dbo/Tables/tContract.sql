CREATE TABLE [dbo].[tContract] (
    [IdContract]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [NumContract]   NVARCHAR (20)  NULL,
    [DateContract]  DATETIME       NULL,
    [ScanContract]  NVARCHAR (250) NULL,
    [IdOContragent] BIGINT         NULL,
    CONSTRAINT [PK_tContract] PRIMARY KEY CLUSTERED ([IdContract] ASC),
    CONSTRAINT [FK_tContract_tblContragent] FOREIGN KEY ([IdOContragent]) REFERENCES [dbo].[tblContragent] ([IdContragent])
);

