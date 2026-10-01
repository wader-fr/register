CREATE TABLE [dbo].[tSubDocIn] (
    [IdSubDocIn]      INT            IDENTITY (1, 1) NOT NULL,
    [ANumSubDocIn]    TINYINT        NULL,
    [NumSubDocIn]     VARCHAR (10)   NULL,
    [DateSubDocIn]    DATETIME       NULL,
    [NumSubDocInOut]  VARCHAR (10)   NULL,
    [DateSubDocInOut] DATETIME       NULL,
    [IdODocIn]        BIGINT         NULL,
    [usr]             VARCHAR (50)   CONSTRAINT [DF_tSubDocIn_usr] DEFAULT (user_name()) NULL,
    [HostName]        VARCHAR (15)   CONSTRAINT [DF_tSubDocIn_HostName] DEFAULT (host_name()) NULL,
    [DateAdded]       DATETIME       CONSTRAINT [DF_Table_1_DateAdd] DEFAULT (getdate()) NULL,
    [Scan]            NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_tSubDocIn] PRIMARY KEY CLUSTERED ([IdSubDocIn] ASC),
    CONSTRAINT [FK_tSubDocIn_tblDocIn] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tgSubDocInIns] 
   ON  [dbo].[tSubDocIn]
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;

	DECLARE @NextNum int
			,@Num varchar(10)

	SELECT @NextNum = ISNULL(MAX(sdi.ANumSubDocIn), 0) + 1
	FROM dbo.tSubDocIn sdi
				INNER JOIN inserted i ON sdi.IdODocIn = i.IdODocIn

	SELECT @Num = (CONVERT (varchar(10), di.NumIn) + '/' + CONVERT(varchar(2), @NextNum) + '-' + di.Suffics)
	FROM dbo.tblDocIn di
			INNER JOIN inserted i ON di.IdDocIn = i.IdODocIn

	UPDATE dbo.tSubDocIn
	SET ANumSubDocIn = @NextNum, NumSubDocIn = @Num
	WHERE IdSubDocIn = (SELECT i.IdSubDocIn FROM inserted i)

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tgSubCount]
   ON [dbo].[tSubDocIn]
   AFTER INSERT, DELETE
AS 
BEGIN

	SET NOCOUNT ON;

   DECLARE @SubCount int
	,@IdDocIn bigint

	SELECT @IdDocIn = i.IdODocIn FROM inserted i

   SELECT @SubCount = COUNT(*) FROM [dbo].[tSubDocIn] sdi WHERE sdi.IdODocIn = @IdDocIn

	IF @SubCount > 0 SET @SubCount = 1 ELSE SET @SubCount = 0

	UPDATE [dbo].[tblDocIn] 
	SET SubDocC = @SubCount
	WHERE IdDocIn = @IdDocIn

END

GO
DISABLE TRIGGER [dbo].[tgSubCount]
    ON [dbo].[tSubDocIn];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[tSubDocIn] TO [Admin]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [Sampler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [Maneger]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [Expert]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [Boss]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[tSubDocIn] TO [Admin]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[tSubDocIn] TO [Admin]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSubDocIn] TO [RegistrarB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[tSubDocIn] TO [Admin]
    AS [dbo];

