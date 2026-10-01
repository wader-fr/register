CREATE TABLE [dbo].[tEmpApp] (
    [IdOApp]      BIGINT        NULL,
    [IdOEmp]      INT           NULL,
    [IdODept]     INT           NULL,
    [IdOTypeEtap] INT           NULL,
    [DateApp]     DATETIME      NULL,
    [IdODocOut]   BIGINT        NULL,
    [Depts]       VARCHAR (MAX) NULL,
    [Emps]        VARCHAR (MAX) NULL,
    CONSTRAINT [FK_tEmpApp_tAppointment] FOREIGN KEY ([IdOApp]) REFERENCES [dbo].[tAppointment] ([IdAppointment]) ON DELETE CASCADE,
    CONSTRAINT [FK_tEmpApp_tblDept] FOREIGN KEY ([IdODept]) REFERENCES [dbo].[tblDept] ([IdDept]),
    CONSTRAINT [FK_tEmpApp_tblEmployee] FOREIGN KEY ([IdOEmp]) REFERENCES [dbo].[tblEmployee] ([IdEmployee]),
    CONSTRAINT [FK_tEmpApp_tTypeAppointment] FOREIGN KEY ([IdOTypeEtap]) REFERENCES [dbo].[tTypeAppointment] ([IdTypeAppointment])
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tEmpApp] TO [Maneger]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tEmpApp] TO [Boss]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tEmpApp] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tEmpApp] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tEmpApp] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tEmpApp] TO [Maneger]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tEmpApp] TO [Boss]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tEmpApp] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tEmpApp] TO [Maneger]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tEmpApp] TO [Boss]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tEmpApp] TO [Admin]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[tEmpApp] TO [Boss]
    AS [dbo];

