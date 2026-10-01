CREATE TABLE [dbo].[tblExp] (
    [IdExpType] INT           IDENTITY (1, 1) NOT NULL,
    [ExpType]   VARCHAR (150) NULL,
    [TypeDoc]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_tblExp] PRIMARY KEY CLUSTERED ([IdExpType] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'IdExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 8145, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'ExpType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 5790, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblExp', @level2type = N'COLUMN', @level2name = N'TypeDoc';

