
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aContragent1]
	-- DECLARE
	@fName varchar(300) = NULL
	,@sName varchar(20) = NULL
	,@Address varchar(100) = NULL
	,@AddressC varchar(50) = NULL
	,@IdProperty int = NULL
	,@IdTypeContr int = NULL
	,@FirstName varchar(50) = NULL
	,@Patronimic varchar(50) = NULL
	,@LastName varchar(50) = NULL
	,@IdContragent bigint OUT
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO dbo.vContragent (fName, sName, pAddress, pAddressC, IdOProperty, IdOTypeContr, FirstName, Patronimic, LastName)
	VALUES (@fName
	,@sName
	,@Address
	,@AddressC
	,@IdProperty
	,@IdTypeContr
	,@FirstName
	,@Patronimic
	,@LastName)

	SET @IdContragent = @@IDENTITY
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aContragent1] TO [Admin]
    AS [dbo];

