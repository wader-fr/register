CREATE TABLE [dbo].[tAppointment] (
    [IdAppointment] BIGINT             IDENTITY (1, 1) NOT NULL,
    [IdODoc]        BIGINT             NOT NULL,
    [IdOTypeApp]    INT                NOT NULL,
    [DateExec]      DATETIME           NULL,
    [IdOEmp]        INT                NULL,
    [IdODept]       INT                NULL,
    [DateApp]       DATETIMEOFFSET (7) CONSTRAINT [DF_tAppointment_DateApp] DEFAULT (sysdatetime()) NULL,
    [Emps]          VARCHAR (MAX)      NULL,
    [Depts]         VARCHAR (MAX)      NULL,
    [IdsEmp]        VARCHAR (MAX)      NULL,
    [IdsDept]       VARCHAR (MAX)      NULL,
    [Usr]           NVARCHAR (50)      CONSTRAINT [DF_tAppointment_Usr] DEFAULT (user_name()) NULL,
    [Host]          NVARCHAR (50)      CONSTRAINT [DF_tAppointment_Hosr] DEFAULT (host_name()) NULL,
    [IdsDeptO]      VARCHAR (MAX)      NULL,
    [IdsEmpO]       VARCHAR (MAX)      NULL,
    CONSTRAINT [PK_t] PRIMARY KEY CLUSTERED ([IdAppointment] ASC),
    CONSTRAINT [FK_tAppointment_tblDept] FOREIGN KEY ([IdODept]) REFERENCES [dbo].[tblDept] ([IdDept]),
    CONSTRAINT [FK_tAppointment_tblDocIn] FOREIGN KEY ([IdODoc]) REFERENCES [dbo].[tblDocIn] ([IdDocIn]),
    CONSTRAINT [FK_tAppointment_tblEmployee] FOREIGN KEY ([IdOEmp]) REFERENCES [dbo].[tblEmployee] ([IdEmployee]),
    CONSTRAINT [FK_tAppointment_tTypeAppointment] FOREIGN KEY ([IdOTypeApp]) REFERENCES [dbo].[tTypeAppointment] ([IdTypeAppointment])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UK_tAppointment]
    ON [dbo].[tAppointment]([IdODoc] ASC, [IdOTypeApp] ASC);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tgAppAddEdit]
   ON dbo.tAppointment
   AFTER INSERT, UPDATE
AS 
BEGIN


	SET NOCOUNT ON;

	DECLARE @IdDept int = NULL
			,@idEmp int = NULL

	SELECT @idEmp = e.IdEmployee, @IdDept = e.IdODept FROM dbo.tblEmployee e WHERE e.lgn = CURRENT_USER


	INSERT INTO dbo.tEmpApp (IdOApp, IdODept, IdOEmp, IdOTypeEtap, DateApp, Depts, Emps)
	SELECT i.IdAppointment, ISNULL(@IdDept, i.IdODept), ISNULL(@idEmp, i.IdOEmp), i.IdOTypeApp, GETDATE(), i.Depts, i.Emps
	FROM inserted i

END
