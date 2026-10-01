CREATE TABLE [dbo].[tIndexes] (
    [IdIndexes] INT    IDENTITY (1, 1) NOT NULL,
    [IdOIndex]  INT    NULL,
    [IdODocOut] BIGINT NULL,
    CONSTRAINT [PK_tIndexes] PRIMARY KEY CLUSTERED ([IdIndexes] ASC),
    CONSTRAINT [FK_tIndexes_tDocOut] FOREIGN KEY ([IdODocOut]) REFERENCES [dbo].[tDocOut] ([IdDocOut]) ON DELETE CASCADE,
    CONSTRAINT [FK_tIndexes_tIndex] FOREIGN KEY ([IdOIndex]) REFERENCES [dbo].[tIndex] ([IdIndex])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tIndexes]
    ON [dbo].[tIndexes]([IdODocOut] ASC, [IdOIndex] ASC);

