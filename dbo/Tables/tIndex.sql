CREATE TABLE [dbo].[tIndex] (
    [IdIndex]   INT            IDENTITY (1, 1) NOT NULL,
    [NameIndex] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tIndex] PRIMARY KEY CLUSTERED ([IdIndex] ASC)
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tIndex] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tIndex] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tIndex] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tIndex] TO [Admin]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[tIndex] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tIndex] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tIndex] TO [Admin]
    AS [dbo];

