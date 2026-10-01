CREATE TABLE [dbo].[tSelPlan] (
    [IdSelPlan] BIGINT   IDENTITY (1, 1) NOT NULL,
    [IdOOdocIn] BIGINT   NULL,
    [NumA]      INT      NULL,
    [YearA]     CHAR (4) NULL,
    [Suff]      CHAR (2) CONSTRAINT [DF_tSelPlan_Suff] DEFAULT ([dbo].[fnSuff]()) NULL,
    [IdOEmp]    INT      NULL,
    [IdODept]   INT      NULL,
    CONSTRAINT [PK_tSelPlan] PRIMARY KEY CLUSTERED ([IdSelPlan] ASC),
    CONSTRAINT [FK_tSelPlan_tblDocIn] FOREIGN KEY ([IdOOdocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);

