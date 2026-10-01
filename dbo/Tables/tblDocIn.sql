CREATE TABLE [dbo].[tblDocIn] (
    [IdDocIn]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [NumIn]         INT            NOT NULL,
    [NumInS]        AS             ((CONVERT([nvarchar](10),[NumIn],(0))+'-')+[Suffics]),
    [Suffics]       CHAR (2)       NOT NULL,
    [DateIn]        DATETIME       NOT NULL,
    [NumOut]        VARCHAR (50)   NULL,
    [DateOut]       DATETIME       NULL,
    [DatePlane]     DATETIME       NULL,
    [DateEnd]       DATETIME       NULL,
    [NumInsp]       VARCHAR (50)   NULL,
    [DateInsp]      DATETIME       NULL,
    [NumCancel]     NVARCHAR (20)  NULL,
    [DateCancel]    DATETIME       NULL,
    [NumCancelOut]  NVARCHAR (20)  NULL,
    [DateCancelOut] DATETIME       NULL,
    [Dept]          VARCHAR (2000) NULL,
    [DeptF]         VARCHAR (MAX)  NULL,
    [NoteDoc]       VARCHAR (MAX)  NULL,
    [YearDoc]       CHAR (4)       NULL,
    [IdOContragent] BIGINT         NULL,
    [IdOObject]     BIGINT         NULL,
    [Object]        VARCHAR (MAX)  NULL,
    [IdOTypeDoc]    INT            NULL,
    [IdOTypeWork]   INT            NULL,
    [Usr]           VARCHAR (50)   CONSTRAINT [DF_tblDocIn_Usr] DEFAULT (user_name()) NULL,
    [HostName]      VARCHAR (15)   CONSTRAINT [DF_tblDocIn_HostName] DEFAULT (host_name()) NULL,
    [DateAdded]     DATETIME       CONSTRAINT [DF_tblDocIn_DateAdded] DEFAULT (getdate()) NULL,
    [NoEx]          BIT            CONSTRAINT [DF_tblDocIn_NoEx] DEFAULT ((0)) NOT NULL,
    [NumInA]        AS             ((((CONVERT([varchar](10),[NumIn],(0))+'-')+[Suffics])+' от ')+CONVERT([varchar](10),[DateIn],(104))) PERSISTED,
    [ScanDocIn]     NVARCHAR (500) NULL,
    [Emps]          VARCHAR (MAX)  NULL,
    [ScanPathDocIn] AS             ((((('\'+[YearDoc])+'\')+CONVERT([nvarchar](20),[NumIn],(0)))+'-')+[Suffics]),
    [Analisis]      NVARCHAR (MAX) CONSTRAINT [DF_tblDocIn_Analisis] DEFAULT ('') NULL,
    [Nom#]          VARCHAR (15)   NULL,
    [NomYear]       CHAR (4)       NULL,
    [NomFolder]     VARCHAR (15)   NULL,
    [NomFile]       VARCHAR (15)   NULL,
    [IdOContract]   BIGINT         NULL,
    [AttachC]       BIT            NULL,
    [SubDocC]       BIT            NULL,
    CONSTRAINT [PK_tblReestrDoc] PRIMARY KEY CLUSTERED ([IdDocIn] ASC),
    CONSTRAINT [FK_tblDocIn_tblContragent] FOREIGN KEY ([IdOContragent]) REFERENCES [dbo].[tblContragent] ([IdContragent]),
    CONSTRAINT [FK_tblDocIn_tblContragent1] FOREIGN KEY ([IdOObject]) REFERENCES [dbo].[tblContragent] ([IdContragent]),
    CONSTRAINT [FK_tblDocIn_tblDocType] FOREIGN KEY ([IdOTypeDoc]) REFERENCES [dbo].[tblDocType] ([IdDocType]),
    CONSTRAINT [FK_tblDocIn_tblWorkType] FOREIGN KEY ([IdOTypeWork]) REFERENCES [dbo].[tblWorkType] ([IdWorkType]),
    CONSTRAINT [FK_tblDocIn_tContract] FOREIGN KEY ([IdOContract]) REFERENCES [dbo].[tContract] ([IdContract])
);


GO
CREATE TRIGGER [tgDocInInsert]
ON dbo.tblDocIn
AFTER INSERT
AS
  BEGIN
 IF EXISTS(SELECT * FROM dbo.tblDocIn di INNER JOIN inserted i ON i.IdDocIn <> di.IdDocIn WHERE di.Usr = CURRENT_USER AND di.IdOContragent IS NULL AND di.IdOTypeDoc IS NULL)
      BEGIN
        RAISERROR ('Добавление невозможно, так как есть незаполненные документы!', 16, 1)
        ROLLBACK TRANSACTION
      END
  END

GO
DISABLE TRIGGER [dbo].[tgDocInInsert]
    ON [dbo].[tblDocIn];


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdDocIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Suffics';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'dd.mm.yyyy', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DatePlane';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NumInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DateInsp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'Dept';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'DeptF';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'NoteDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'YearDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Контрагент', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOContragent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = 1417, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Объект надзора', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Тип документа', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeDoc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_AggregateType', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnHidden', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnOrder', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_ColumnWidth', @value = -1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_CurrencyLCID', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';


GO
EXECUTE sp_addextendedproperty @name = N'MS_TextAlign', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblDocIn', @level2type = N'COLUMN', @level2name = N'IdOTypeWork';

