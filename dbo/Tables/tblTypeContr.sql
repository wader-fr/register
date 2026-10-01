CREATE TABLE [dbo].[tblTypeContr] (
    [IdTypeContr] INT          IDENTITY (1, 1) NOT NULL,
    [TypeContr]   VARCHAR (50) NULL,
    CONSTRAINT [PK_tblTypeContr] PRIMARY KEY CLUSTERED ([IdTypeContr] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'IdTypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 4470, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeContr', @level2type = N'COLUMN', @level2name = N'TypeContr';

