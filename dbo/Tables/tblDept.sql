CREATE TABLE [dbo].[tblDept] (
    [IdDept]    INT           IDENTITY (1, 1) NOT NULL,
    [NameDept]  VARCHAR (150) NULL,
    [PIdDept]   INT           NULL,
    [sNameDept] VARCHAR (10)  NULL,
    [IdOFilial] INT           NULL,
    [Act]       BIT           CONSTRAINT [DF_tblDept_Act] DEFAULT ((1)) NULL,
    [TLC]       BIT           CONSTRAINT [DF_tblDept_TLC] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_tblDept] PRIMARY KEY CLUSTERED ([IdDept] ASC),
    CONSTRAINT [FK_tblDept_tblFilial] FOREIGN KEY ([IdOFilial]) REFERENCES [dbo].[tblFilial] ([IdFilial])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 7635, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'NameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'PIdDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1620, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'sNameDept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'IdOFilial';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'106', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDept', @level2type = N'COLUMN', @level2name = N'Act';

