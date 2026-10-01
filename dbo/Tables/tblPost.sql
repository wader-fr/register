CREATE TABLE [dbo].[tblPost] (
    [IdPost] INT          IDENTITY (1, 1) NOT NULL,
    [Post]   VARCHAR (50) NULL,
    CONSTRAINT [PK_tblPost] PRIMARY KEY CLUSTERED ([IdPost] ASC)
);




GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblPost]
    ON [dbo].[tblPost]([Post] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'IdPost';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 4935, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblPost', @level2type = N'COLUMN', @level2name = N'Post';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblPost] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblPost] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblPost] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblPost] TO [Admin]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[tblPost] TO [RegistrarM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[tblPost] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblPost] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblPost] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblPost] TO [Admin]
    AS [dbo];

