CREATE PROCEDURE [dbo].[aSMeasPlan]
    @IdType     int,
    @DatePlane  datetime,
    @IdDocIn    bigint,
    @IdSMeas    bigint OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        INSERT INTO dbo.tSMeasPlan
            (IdOSMeasType, DateSMeas, IdODocIn)
        VALUES
            (@IdType, @DatePlane, @IdDocIn);

        SET @IdSMeas = CAST(SCOPE_IDENTITY() AS bigint);

    END TRY
    BEGIN CATCH

        DECLARE @Msg nvarchar(4000) = ERROR_MESSAGE();

        THROW 51000, @Msg, 1;

    END CATCH
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aSMeasPlan] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[aSMeasPlan] TO [Expert]
    AS [dbo];

