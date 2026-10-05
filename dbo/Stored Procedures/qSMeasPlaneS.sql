
CREATE PROCEDURE qSMeasPlaneS
    @Id AS bigint
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @Status varchar(20);

    -- Получаем последний зарегистрированный статус плана.
    --
    -- CROSS APPLY здесь используется для выбора одной,
    -- самой последней записи из истории статусов.
    -- Сначала сортируем по дате статуса, а IdSMeasStatus
    -- используем вторым критерием для однозначности,
    -- если несколько статусов имеют одинаковую дату.
    --
    -- Этот SELECT выполняется отдельно от основного,
    -- чтобы основной Recordset оставался основанным
    -- только на dbo.tSMeasPlan и был обновляемым в Access.
    SELECT @Status = sm.SMeasStatus
    FROM dbo.tSMeasPlan smp
    CROSS APPLY
    (
        SELECT TOP 1
            s.SMeasStatus
        FROM dbo.tSMeasStatus sms
        INNER JOIN dbo.tStatuses s
            ON s.IdSMeasStatuses = sms.IdOStatus
        WHERE sms.IdOSMeasPlan = smp.IdSMeas
        ORDER BY
            sms.DateStatus DESC,
            sms.IdSMeasStatus DESC
    ) sm
    WHERE smp.IdSMeas = @Id;

    -- Возвращаем данные самого плана.
    --
    -- Основной Recordset намеренно строится только
    -- на dbo.tSMeasPlan: это важно для обновляемости
    -- Recordset формы SMeasPlanEdit в Access.
    --
    -- @Status добавляется как вычисляемое поле только
    -- для отображения текущего статуса и не является
    -- редактируемым полем таблицы tSMeasPlan.
    --
    -- Если у плана ещё нет истории статусов,
    -- @Status останется NULL, но сам план всё равно
    -- будет возвращён.
    SELECT
        smp.IdSMeas,
        smp.FNum,
        smp.DateSMeas,
        smp.IdODocIn,
        smp.DateExecBeg,
        smp.DateExecEnd,
        smp.IdOSMeasType,
        @Status AS SMeasStatus
    FROM dbo.tSMeasPlan smp
    WHERE smp.IdSMeas = @Id;

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSMeasPlaneS] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSMeasPlaneS] TO [Maneger]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSMeasPlaneS] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[qSMeasPlaneS] TO [Admin]
    AS [dbo];

