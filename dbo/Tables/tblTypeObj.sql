CREATE TABLE [dbo].[tblTypeObj] (
    [IdTypeObj] INT           IDENTITY (1, 1) NOT NULL,
    [CodeObj]   VARCHAR (50)  NULL,
    [TypeObj]   VARCHAR (250) NULL,
    [Exp]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_tblTypeObj] PRIMARY KEY CLUSTERED ([IdTypeObj] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'IdTypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 10440, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'TypeObj';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'Exp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblTypeObj', @level2type = N'COLUMN', @level2name = N'Exp';

