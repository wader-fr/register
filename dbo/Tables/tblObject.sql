CREATE TABLE [dbo].[tblObject] (
    [IdObject]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [NameObject] VARCHAR (1000) NOT NULL,
    [pAddress]   VARCHAR (150)  NULL,
    [IdODocIn]   BIGINT         NULL,
    [IdODept]    INT            NULL,
    [IdOEmp]     INT            NULL,
    [DateCont]   DATETIME       NULL,
    [DateEnd]    DATETIME       NULL,
    [Usr]        VARCHAR (50)   CONSTRAINT [DF_tblObject_Usr] DEFAULT (user_name()) NULL,
    [HostName]   VARCHAR (15)   CONSTRAINT [DF_tblObject_HostName] DEFAULT (host_name()) NULL,
    [DateAdded]  DATETIME       CONSTRAINT [DF_tblObject_DateAdded] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_tblObject] PRIMARY KEY CLUSTERED ([IdObject] ASC),
    CONSTRAINT [CK_tblObject] CHECK ([NameObject] IS NOT NULL OR [pAddress] IS NOT NULL)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'NameObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 6375, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'pAddress';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdODept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblObject', @level2type = N'COLUMN', @level2name = N'IdOEmp';

