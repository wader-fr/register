CREATE PROCEDURE [dbo].[qContractC]
	--DECLARE
	@IdContragent bigint
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @t table (Id bigint, Num varchar(500))

	INSERT INTO @t
	VALUES (0, '-=Добавить/редактировать=-')

	INSERT INTO @t
	SELECT IdContract, '№ ' + NumContract + ' от ' + CONVERT(char(10), DateContract, 104)  FROM dbo.tContract WHERE IdOContragent = @IdContragent

	SELECT * FROM @t

END
