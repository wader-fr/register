CREATE TABLE [dbo].[tTypeAppointment] (
    [IdTypeAppointment] INT           NOT NULL,
    [TypeApp]           NVARCHAR (50) NULL,
    CONSTRAINT [PK_tTypeAppointment] PRIMARY KEY CLUSTERED ([IdTypeAppointment] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeAppointment] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tTypeAppointment] TO PUBLIC
    AS [dbo];

