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


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAssignment] TO [Maneger]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAssignment] TO [Boss]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tAssignment] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAssignment] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAssignment] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAssignment] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAssignment] TO [Boss]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tAssignment] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAssignment] TO [Maneger]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAssignment] TO [Boss]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tAssignment] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tAssignment] TO [Maneger]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tAssignment] TO [Boss]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tAssignment] TO [Admin]
    AS [dbo];

