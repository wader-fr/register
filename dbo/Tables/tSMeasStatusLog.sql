CREATE TABLE [dbo].[tSMeasStatusLog] (
    [IdSMeasStatus] INT      IDENTITY (1, 1) NOT NULL,
    [IdOStatuses]   INT      NULL,
    [IdOEmp]        INT      NULL,
    [DateStatus]    DATETIME CONSTRAINT [DF_tsMeasStatus_DateStatus] DEFAULT (getdate()) NULL,
    [IdOSMeas]      BIGINT   NULL,
    CONSTRAINT [PK_tsMeasStatus] PRIMARY KEY CLUSTERED ([IdSMeasStatus] ASC),
    CONSTRAINT [FK_tsMeasStatus_tSMeasPlan] FOREIGN KEY ([IdOSMeas]) REFERENCES [dbo].[tSMeasPlan] ([IdSMeas]),
    CONSTRAINT [FK_tsMeasStatus_tStatuses] FOREIGN KEY ([IdOStatuses]) REFERENCES [dbo].[tStatuses] ([IdSMeasStatuses])
);

