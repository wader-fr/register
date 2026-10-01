CREATE TABLE [dbo].[tblResult] (
    [IdResult] SMALLINT     NOT NULL,
    [Result]   VARCHAR (50) NULL,
    CONSTRAINT [PK_tblResult] PRIMARY KEY CLUSTERED ([IdResult] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Orientation', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'tblResult';


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblResult] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblResult] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblResult] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblResult] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tblResult] TO [Admin]
    AS [dbo];

