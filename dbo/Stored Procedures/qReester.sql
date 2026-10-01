-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[qReester]
	--DECLARE
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Attestat nvarchar(20) = dbo.fnGetOption('AttestatOI')
	DECLARE @Email nvarchar(20) = dbo.fnGetOption('Email')

	SELECT @Attestat, @Email, do.DateDocOut
	,do.NumDocOut +
	CASE
      WHEN do.Suffics IS NOT NULL THEN '-' + do.Suffics
    END NumOutS

	FROM dbo.tDocOut do

END
