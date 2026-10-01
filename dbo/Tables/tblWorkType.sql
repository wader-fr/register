CREATE TABLE [dbo].[tblWorkType] (
    [IdWorkType] INT           IDENTITY (1, 1) NOT NULL,
    [WorkType]   VARCHAR (100) NULL,
    [IdOService] TINYINT       NULL,
    [IdOBudget]  TINYINT       NULL,
    CONSTRAINT [PK_tblWortType] PRIMARY KEY CLUSTERED ([IdWorkType] ASC),
    CONSTRAINT [FK_tblWorkType_tblBudget] FOREIGN KEY ([IdOBudget]) REFERENCES [dbo].[tblBudget] ([IdBudget]),
    CONSTRAINT [FK_tblWorkType_tblService] FOREIGN KEY ([IdOService]) REFERENCES [dbo].[tblService] ([IdService])
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdWorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 7740, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'WorkType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AllowValueListEdits', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnCount', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidths', @value = N'0.000;1701.000', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'111', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ListItemsEditForm', @value = NULL, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_RowSource', @value = N'dbo.tblService', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ShowOnlyRowSourceValues', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOService';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AllowValueListEdits', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnCount', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidths', @value = N'0.000;1701.000', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'111', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ListItemsEditForm', @value = NULL, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_RowSource', @value = N'dbo.tblBudget', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ShowOnlyRowSourceValues', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblWorkType', @level2type = N'COLUMN', @level2name = N'IdOBudget';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblWorkType] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblWorkType] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblWorkType] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblWorkType] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblWorkType] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblWorkType] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblWorkType] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblWorkType] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblWorkType] TO [Admin]
    AS [dbo];

