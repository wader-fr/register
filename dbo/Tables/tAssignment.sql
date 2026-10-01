CREATE TABLE [dbo].[tAssignment] (
    [IdAssignment] BIGINT         IDENTITY (1, 1) NOT NULL,
    [IdODocIn]     BIGINT         NULL,
    [IdODept]      INT            NULL,
    [IdOEmp]       INT            NULL,
    [Assignment]   NVARCHAR (500) NULL,
    [User]         VARCHAR (20)   CONSTRAINT [DF_tAssignment_User] DEFAULT (user_name()) NULL,
    [Comp]         VARCHAR (20)   CONSTRAINT [DF_tAssignment_Comp] DEFAULT (host_name()) NULL,
    [IdOEmpV]      INT            NULL,
    CONSTRAINT [PK_tAssignment] PRIMARY KEY CLUSTERED ([IdAssignment] ASC)
);

