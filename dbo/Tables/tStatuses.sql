CREATE TABLE [dbo].[tStatuses] (
    [IdSMeasStatuses] INT           IDENTITY (1, 1) NOT NULL,
    [IdOrdr]          INT           NULL,
    [SMeasStatus]     NVARCHAR (50) NULL,
    CONSTRAINT [PK_tStatuses] PRIMARY KEY CLUSTERED ([IdSMeasStatuses] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tStatuses] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tStatuses] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tStatuses] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tStatuses] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tStatuses] TO PUBLIC
    AS [dbo];

