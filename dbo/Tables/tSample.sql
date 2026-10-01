CREATE TABLE [dbo].[tSample] (
    [IdSample]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [TestObjectName] NVARCHAR (250) NULL,
    [IdOSamplingND]  INT            NULL,
    [IdOResearchND]  INT            NULL,
    [SampleAmount]   NVARCHAR (250) NULL,
    [Notes]          NVARCHAR (MAX) NULL,
    [IdOSMeas]       BIGINT         NULL,
    CONSTRAINT [PK_tSample] PRIMARY KEY CLUSTERED ([IdSample] ASC),
    CONSTRAINT [FK_tSample_tND] FOREIGN KEY ([IdOSamplingND]) REFERENCES [dbo].[tND] ([IdND]),
    CONSTRAINT [FK_tSample_tND1] FOREIGN KEY ([IdOResearchND]) REFERENCES [dbo].[tND] ([IdND]),
    CONSTRAINT [FK_tSample_tSMeasPlan] FOREIGN KEY ([IdOSMeas]) REFERENCES [dbo].[tSMeasPlan] ([IdSMeas])
);

