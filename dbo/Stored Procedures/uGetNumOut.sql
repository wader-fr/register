
-- Выдача номера исходящего документа.
-- Совместимо с SQL Server 2008.
-- Группа задана: нумерация по группе и году.
-- Группа NULL: нумерация по типу и году.
-- Параллельные вызовы ждут освобождения блокировки.
-- При взаимной блокировке выполняется повторная попытка.

CREATE PROCEDURE dbo.uGetNumOut
    @IdDocOut bigint
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
         @IdTypeDoc int
        ,@IdGroup smallint
        ,@Year char(10)
        ,@NumOut int
        ,@LockResult int
        ,@LockResource nvarchar(255)
        ,@ErrorNumber int
        ,@ErrorMessage nvarchar(4000);

    -- Повторяем только после взаимной блокировки.
    -- Ошибки данных и другие неисправимые ошибки не зацикливаем.
    WHILE 1 = 1
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Получаем параметры документа.
            SELECT
                 @IdTypeDoc = d.IdOTypeDocOut
                ,@IdGroup = t.AutoNumGroup
                ,@Year = d.YearOut
            FROM dbo.tDocOut AS d
            INNER JOIN dbo.tblDocTypeOut AS t
                ON t.IdDocTypeOut = d.IdOTypeDocOut
            WHERE d.IdDocOut = @IdDocOut;

            -- Без типа и года корректно назначить номер нельзя.
            IF @IdTypeDoc IS NULL
                RAISERROR(
                    N'Документ не найден или не задан его тип.',
                    16, 1
                );

            IF @Year IS NULL OR LTRIM(RTRIM(@Year)) = ''
                RAISERROR(
                    N'У документа не задан год нумерации.',
                    16, 1
                );

            -- Формируем отдельную блокировку для каждой области
            -- нумерации: группа + год либо тип + год.
            SET @LockResource =
                N'uGetNumOut:' + RTRIM(@Year) + N':'
                + CASE
                    WHEN @IdGroup IS NOT NULL
                        THEN N'G:' + CONVERT(nvarchar(20), @IdGroup)
                    ELSE
                        N'T:' + CONVERT(nvarchar(20), @IdTypeDoc)
                  END;

            -- -1: ждём освобождения блокировки без ограничения времени.
            EXEC @LockResult = sys.sp_getapplock
                 @Resource = @LockResource
                ,@LockMode = 'Exclusive'
                ,@LockOwner = 'Transaction'
                ,@LockTimeout = -1;

            -- SQL Server сообщил, что эта транзакция выбрана
            -- жертвой взаимной блокировки: повторяем попытку.
            IF @LockResult = -3
            BEGIN
                ROLLBACK TRANSACTION;
                WAITFOR DELAY '00:00:01';
                CONTINUE;
            END;

            -- Другие отрицательные коды означают, что блокировка
            -- не получена по иной причине.
            IF @LockResult < 0
                RAISERROR(
                    N'Не удалось получить блокировку нумерации.',
                    16, 1
                );

            -- Повторно читаем номер после получения блокировки:
            -- другой вызов мог уже назначить его этому документу.
            SET @NumOut = NULL;

            SELECT @NumOut = ANumDocOut
            FROM dbo.tDocOut
            WHERE IdDocOut = @IdDocOut;

            IF @@ROWCOUNT = 0
                RAISERROR(N'Документ не найден.', 16, 1);

            -- Уже назначенный номер не меняем.
            IF @NumOut IS NULL
            BEGIN
                -- При заданной группе учитываем только всю группу.
                -- При NULL учитываем только тот же тип документа.
                SELECT
                    @NumOut = ISNULL(MAX(d.ANumDocOut), 0) + 1
                FROM dbo.tDocOut AS d
                INNER JOIN dbo.tblDocTypeOut AS t
                    ON t.IdDocTypeOut = d.IdOTypeDocOut
                WHERE d.YearOut = @Year
                  AND
                  (
                        (@IdGroup IS NOT NULL
                         AND t.AutoNumGroup = @IdGroup)
                     OR (@IdGroup IS NULL
                         AND d.IdOTypeDocOut = @IdTypeDoc)
                  );

                -- Защита от повторного присвоения номера документу.
                UPDATE dbo.tDocOut
                SET ANumDocOut = @NumOut
                WHERE IdDocOut = @IdDocOut
                  AND ANumDocOut IS NULL;
            END;

            COMMIT TRANSACTION;
            RETURN;
        END TRY
        BEGIN CATCH
            -- Сохраняем сведения об ошибке до отката транзакции.
            SET @ErrorNumber = ERROR_NUMBER();
            SET @ErrorMessage = ERROR_MESSAGE();

            IF XACT_STATE() <> 0
                ROLLBACK TRANSACTION;

            -- Обычный deadlock SQL Server: ждём и повторяем.
            IF @ErrorNumber = 1205
            BEGIN
                WAITFOR DELAY '00:00:01';
                CONTINUE;
            END;

            -- Неисправимые ошибки не маскируем и не зацикливаем.
            -- Их должен обработать вызывающий код.
            RAISERROR(N'%s', 16, 1, @ErrorMessage);
            RETURN;
        END CATCH;
    END;
END;
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uGetNumOut] TO [Sampler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uGetNumOut] TO [Expert]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[uGetNumOut] TO [Admin]
    AS [dbo];

