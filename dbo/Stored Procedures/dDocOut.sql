-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[dDocOut]
--	DECLARE
	@IdDocOut BIGINT
	,@Result int out

AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @MaxNum INT, @AutoNumGroup INT, @IdDocType int, @Year char(4)

	IF EXISTS (SELECT * FROM dbo.tDocOut do WHERE do.IdDocOut = @IdDocOut AND do.NumDocOut IS NULL)
		DELETE FROM dbo.tDocOut WHERE IdDocOut = @IdDocOut

	ELSE
		BEGIN
			SELECT @AutoNumGroup = DTO.AutoNumGroup
			FROM tDocOut do 
					INNER JOIN tblDocTypeOut DTO ON do.IdOTypeDocOut = DTO.IdDocTypeOut
			WHERE do.IdDocOut = @IdDocOut

			SELECT @IdDocType = do.IdOTypeDocOut, @Year = do.YearOut
			FROM tDocOut do 
			WHERE do.IdDocOut = @IdDocOut

			IF @AutoNumGroup IS NULL
				SELECT @MaxNum = MAX(do.ANumDocOut) 
				FROM tDocOut do
				WHERE do.IdOTypeDocOut = @IdDocType AND do.YearOut = @Year
			ELSE
				SELECT @MaxNum= MAX(do.ANumDocOut)
				FROM dbo.tDocOut do
					LEFT OUTER JOIN tblDocTypeOut dt ON do.IdOTypeDocOut = dt.IdDocTypeOut
				WHERE do.YearOut = @Year
					AND dt.AutoNumGroup = @AutoNumGroup

			DELETE
			FROM tDocOut
			WHERE ANumDocOut = @MaxNum AND IdDocOut = @IdDocOut
		END

	set @Result =  @@rowcount
END
