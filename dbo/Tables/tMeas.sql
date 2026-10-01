CREATE TABLE [dbo].[tMeas] (
    [IdMeas]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [MeasName]        NVARCHAR (250) NULL,
    [IdOMeasMethodND] INT            NULL,
    [MeasPointCount]  INT            NULL,
    [Notes]           NVARCHAR (MAX) NULL,
    [IdODMeasPlane]   BIGINT         NULL,
    CONSTRAINT [PK_tMeas] PRIMARY KEY CLUSTERED ([IdMeas] ASC),
    CONSTRAINT [FK_tMeas_tND] FOREIGN KEY ([IdOMeasMethodND]) REFERENCES [dbo].[tND] ([IdND]),
    CONSTRAINT [FK_tMeas_tSMeasPlan] FOREIGN KEY ([IdODMeasPlane]) REFERENCES [dbo].[tSMeasPlan] ([IdSMeas])
);

