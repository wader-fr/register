CREATE TABLE [dbo].[tblFilial] (
    [IdFilial] INT          IDENTITY (1, 1) NOT NULL,
    [FFilial]  VARCHAR (50) NULL,
    [SFilial]  CHAR (10)    NULL,
    CONSTRAINT [PK_tblFilial] PRIMARY KEY CLUSTERED ([IdFilial] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'IdFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 3015, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'FFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblFilial', @level2type = N'COLUMN', @level2name = N'SFilial';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblFilial] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblFilial] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblFilial] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblFilial] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblFilial] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblFilial] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblFilial] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblFilial] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblFilial] TO [Admin]
    AS [dbo];

