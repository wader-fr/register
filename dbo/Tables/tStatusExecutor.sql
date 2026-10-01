CREATE TABLE [dbo].[tStatusExecutor] (
    [IdStatusExtcutor] BIGINT   NOT NULL,
    [IdOSMeasStatus]   BIGINT   NULL,
    [IdOExtcutor]      INT      NULL,
    [DateStatus]       DATETIME NULL,
    CONSTRAINT [PK_tStusExecutor] PRIMARY KEY CLUSTERED ([IdStatusExtcutor] ASC),
    CONSTRAINT [FK_tStusExecutor_tblEmployee] FOREIGN KEY ([IdOExtcutor]) REFERENCES [dbo].[tblEmployee] ([IdEmployee]),
    CONSTRAINT [FK_tStusExecutor_tSMeasStatus] FOREIGN KEY ([IdOSMeasStatus]) REFERENCES [dbo].[tSMeasStatus] ([IdSMeasStatus])
);

