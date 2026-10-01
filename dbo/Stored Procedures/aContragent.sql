-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[aContragent]
	-- DECLARE
	@fName varchar(300) = NULL
	,@sName varchar(50) = NULL
	,@Address varchar(100) = NULL
	,@AddressC varchar(50) = NULL
	,@IdProperty int = NULL
	,@IdTypeContr int = NULL
	,@FirstName varchar(50) = NULL
	,@Patronimic varchar(50) = NULL
	,@LastName varchar(50) = NULL
	,@Return_value bigint OUT
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

	SET @Return_value = @@IDENTITY

END
