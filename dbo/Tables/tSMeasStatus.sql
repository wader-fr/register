CREATE TABLE [dbo].[tSMeasStatus] (
    [IdSMeasStatus] BIGINT         IDENTITY (1, 1) NOT NULL,
    [IdOStatus]     INT            NULL,
    [IdOEmp]        INT            NULL,
    [DateStatus]    DATETIME       NULL,
    [IdOSMeasPlan]  BIGINT         NULL,
    [IdsDept]       NVARCHAR (150) NULL,
    [IdsEmp]        NVARCHAR (150) NULL,
    [IdsEmpResp]    NVARCHAR (50)  NULL,
    [Depts]         NVARCHAR (MAX) NULL,
    [DeptsResp]     NVARCHAR (MAX) NULL,
    [Emps]          NVARCHAR (MAX) NULL,
    [EmpsResp]      NVARCHAR (MAX) NULL,
    [Notes]         NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tSMeasStatus_1] PRIMARY KEY CLUSTERED ([IdSMeasStatus] ASC),
    CONSTRAINT [FK_tSMeasStatus_tblEmployee] FOREIGN KEY ([IdOEmp]) REFERENCES [dbo].[tblEmployee] ([IdEmployee]),
    CONSTRAINT [FK_tSMeasStatus_tSMeasPlan1] FOREIGN KEY ([IdOSMeasPlan]) REFERENCES [dbo].[tSMeasPlan] ([IdSMeas]),
    CONSTRAINT [FK_tSMeasStatus_tStatuses1] FOREIGN KEY ([IdOStatus]) REFERENCES [dbo].[tStatuses] ([IdSMeasStatuses])
);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasStatus_Assignees]
    ON [dbo].[tSMeasStatus]([IdOSMeasPlan] ASC)
    INCLUDE([IdsEmp], [IdsDept]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasStatus_IdOSMeasPlan_DateStatus]
    ON [dbo].[tSMeasStatus]([IdOSMeasPlan] ASC, [DateStatus] DESC, [IdSMeasStatus] DESC)
    INCLUDE([IdOStatus], [IdOEmp], [Notes]) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasStatus_Plan_Status]
    ON [dbo].[tSMeasStatus]([IdOSMeasPlan] ASC, [IdOStatus] ASC)
    INCLUDE([IdOEmp]);


GO
CREATE NONCLUSTERED INDEX [IX_tSMeasStatus_Plan_Date]
    ON [dbo].[tSMeasStatus]([IdOSMeasPlan] ASC, [DateStatus] DESC)
    INCLUDE([IdOStatus]);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSMeasStatus] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasStatus] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSMeasStatus] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSMeasStatus] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSMeasStatus] TO PUBLIC
    AS [dbo];

