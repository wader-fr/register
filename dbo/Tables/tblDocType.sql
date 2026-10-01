CREATE TABLE [dbo].[tblDocType] (
    [IdDocType]  INT           IDENTITY (1, 1) NOT NULL,
    [DocType]    VARCHAR (75)  NULL,
    [Insp]       BIT           NULL,
    [IdOService] TINYINT       NULL,
    [Ordr]       SMALLINT      NULL,
    [sDocType]   NVARCHAR (50) NULL,
    [Act]        BIT           NULL,
    CONSTRAINT [PK_tblDocType] PRIMARY KEY CLUSTERED ([IdDocType] ASC),
    CONSTRAINT [FK_tblDocType_tblService] FOREIGN KEY ([IdOService]) REFERENCES [dbo].[tblService] ([IdService])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 10815, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'106', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'Insp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AllowValueListEdits', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnCount', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidths', @value = N'0.000;1701.000', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'111', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ListItemsEditForm', @value = NULL, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_RowSource', @value = N'dbo.tblService', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ShowOnlyRowSourceValues', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocType', @level2type = N'COLUMN', @level2name = N'IdOService';

