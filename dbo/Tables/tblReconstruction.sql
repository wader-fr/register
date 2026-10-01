CREATE TABLE [dbo].[tblReconstruction] (
    [IDReconstruction] INT          IDENTITY (1, 1) NOT NULL,
    [Reconstruction]   VARCHAR (50) NULL,
    [Exp]              VARCHAR (50) NULL,
    CONSTRAINT [PK_tblReconstruction] PRIMARY KEY CLUSTERED ([IDReconstruction] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'IDReconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 2205, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Reconstruction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblReconstruction', @level2type = N'COLUMN', @level2name = N'Exp';

