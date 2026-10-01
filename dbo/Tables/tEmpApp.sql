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

