CREATE TABLE [dbo].[tAttach] (
    [IdAttach]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [IdODocIn]   BIGINT         NULL,
    [NumAttach]  INT            NULL,
    [NameAttach] NVARCHAR (250) NULL,
    CONSTRAINT [PK_tAttach] PRIMARY KEY CLUSTERED ([IdAttach] ASC),
    CONSTRAINT [FK_tAttach_tblDocIn] FOREIGN KEY ([IdODocIn]) REFERENCES [dbo].[tblDocIn] ([IdDocIn])
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tgAttach]
   ON  [dbo].[tAttach]
   AFTER INSERT, DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @CountAttach int
		,@IdDocIn bigint

	SELECT @IdDocIn = i.IdODocIn FROM inserted i

	SELECT @CountAttach = COUNT(*) FROM dbo.tAttach a WHERE a.IdODocIn = @IdDocIn

		IF @CountAttach > 0 Set @CountAttach = 1 else set @CountAttach = 0

		UPDATE dbo.tblDocIn
		SET [AttachC] = @CountAttach
		WHERE IdDocIn = @IdDocIn
	


END

GO
DISABLE TRIGGER [dbo].[tgAttach]
    ON [dbo].[tAttach];

