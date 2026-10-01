CREATE TABLE [dbo].[tAppointmentSP] (
    [IdAppointmentSP] BIGINT        IDENTITY (1, 1) NOT NULL,
    [IdOSelPlan]      BIGINT        NULL,
    [IdOTypeAppSP]    INT           NULL,
    [DateExec]        DATETIME      NULL,
    [IdOEmp]          INT           NULL,
    [IdODept]         INT           NULL,
    [Emps]            VARCHAR (MAX) NULL,
    [Depts]           VARCHAR (MAX) NULL,
    [IdsEmp]          VARCHAR (MAX) NULL,
    [IdsDept]         VARCHAR (MAX) NULL,
    CONSTRAINT [PK_tAppointmentSP] PRIMARY KEY CLUSTERED ([IdAppointmentSP] ASC),
    CONSTRAINT [FK_tAppointmentSP_tblDept] FOREIGN KEY ([IdODept]) REFERENCES [dbo].[tblDept] ([IdDept]),
    CONSTRAINT [FK_tAppointmentSP_tblEmployee] FOREIGN KEY ([IdOEmp]) REFERENCES [dbo].[tblEmployee] ([IdEmployee]),
    CONSTRAINT [FK_tAppointmentSP_tSelPlan] FOREIGN KEY ([IdOSelPlan]) REFERENCES [dbo].[tSelPlan] ([IdSelPlan]),
    CONSTRAINT [FK_tAppointmentSP_tTypeAppSP] FOREIGN KEY ([IdOTypeAppSP]) REFERENCES [dbo].[tTypeAppSP] ([IdTypeAppSP])
);

