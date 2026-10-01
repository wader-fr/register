CREATE TABLE [dbo].[tTypeAppointment] (
    [IdTypeAppointment] INT           NOT NULL,
    [TypeApp]           NVARCHAR (50) NULL,
    CONSTRAINT [PK_tTypeAppointment] PRIMARY KEY CLUSTERED ([IdTypeAppointment] ASC)
);

