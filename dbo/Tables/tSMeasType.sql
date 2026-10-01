CREATE TABLE [dbo].[tSMeasType] (
    [IdSMeasType] INT           IDENTITY (1, 1) NOT NULL,
    [sMeasType]   NVARCHAR (50) NULL,
    CONSTRAINT [PK_tSMeasType] PRIMARY KEY CLUSTERED ([IdSMeasType] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSMeasType] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasType] TO [Maneger]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSMeasType] TO [Maneger]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSMeasType] TO [Maneger]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSMeasType] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasType] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSMeasType] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSMeasType] TO [Admin]
    AS [dbo];

