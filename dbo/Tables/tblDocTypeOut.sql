CREATE TABLE [dbo].[tblDocTypeOut] (
    [IdDocTypeOut] INT           IDENTITY (1, 1) NOT NULL,
    [DocTypeOut]   VARCHAR (100) NULL,
    [AutoNum]      BIT           CONSTRAINT [DF_tblDocTypeOut_AutoNum] DEFAULT ((0)) NOT NULL,
    [sDocTypeOut]  NVARCHAR (20) NULL,
    [AutoNumGroup] SMALLINT      NULL,
    CONSTRAINT [PK_tblDocTypeOut] PRIMARY KEY CLUSTERED ([IdDocTypeOut] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'IdDocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 6390, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocTypeOut', @level2type = N'COLUMN', @level2name = N'DocTypeOut';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tblDocTypeOut] TO [Admin]
    AS [dbo];

