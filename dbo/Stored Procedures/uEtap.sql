
-- =============================================
-- Author:		Роман Фатеев
-- Create date: 24.01.2024
-- Description:	Добавляет или изменяет этапы обработки докуменов
-- =============================================

CREATE PROCEDURE [dbo].[uEtap]
--DECLARE 
@IdDocIn BIGINT     			--ИД входящего документа
, @IdTypeApp BIGINT				--ИД типа этапа
, @IdEmp VARCHAR(10)			--ИД текущего пользователя
, @IdsEmp VARCHAR(MAX)		--Список ИД пользователей через пробел
, @IdsDept VARCHAR(MAX)		--Список ИД Подразделений через пробел
, @DateEtap DATETIME			--Дата этапа
AS
BEGIN
  SET NOCOUNT ON;

  --Переменные для курсоров
  DECLARE
  --Подразделения
  @IdCDept VARCHAR(10)				--ИД подразделения
 ,@IdCDeptS VARCHAR(MAX) = ''		--Перечисление ИД подразделений
 ,@CDept VARCHAR(20)				--Подразделение
 ,@CDeptS VARCHAR(MAX) = ''		--Перечисление подразделений
 ,@idDept VARCHAR(10) 			--ИД текущего подразделения

  --Исполнители
 ,@IdCEmp VARCHAR(50)			--ИД исполнителя
 ,@idCEmpS VARCHAR(MAX) = ''		--Перечисление ИД исполнителей
 ,@CEmp VARCHAR(20)				--Исполнитель
 ,@CEmpS VARCHAR(MAX) = ''		--Перечисление исполнителей
  --Прочие
 ,@IdApp AS BIGINT;				--ИД текущего этапа

  -- ===========================================================================================
  -- Таблицы со списком подразделений и исполнителей
  DECLARE @tEmp TABLE (
    IdEmp INT
   ,FullName VARCHAR(50)
  );
  DECLARE @tDept TABLE (
    IdDept INT
   ,SName VARCHAR(50)
  );
  -- ===========================================================================================

  -- ===========================================================================================
  -- Если первый этап (назначение отделов), заполнить таблицу с отделами
  IF @IdTypeApp = 1
    INSERT INTO @tDept
      SELECT
        d.IdDept
       ,d.sNameDept
      FROM dbo.tblDept d
      WHERE @IdsDept LIKE '% ' + CONVERT(VARCHAR(50), d.IdDept) + ' %';

  -- ===========================================================================================
  -- Если второй этап (назначение исполнителей), заполнить таблицу отделов и исполнителей
  ELSE
  IF @IdTypeApp = 2
  BEGIN
    -- найти ИД отдела по исполнителю
    SELECT
      @idDept = e.IdODept
    FROM dbo.tblEmployee e
    WHERE e.IdEmployee = @IdEmp;
    -- Если уже былы назначены отделы, добавляем их в переменную
    SELECT
      @IdCDeptS = a.IdsDept
     ,@idCEmpS = a.IdsEmp
    FROM dbo.tAppointment a
    WHERE a.IdODoc = @IdDocIn
    AND a.IdOTypeApp = @IdTypeApp;

    -- исключить текущий отдел, так как в нем изменения, остальные переносим, как есть
    SET @IdCDeptS = REPLACE(@IdCDeptS, @idDept, '');

    -- Составляем новый список исполнителей текущего отдела, остальных переносим
    INSERT INTO @tEmp
      SELECT
        e.IdEmployee
       ,e.FullName
      FROM dbo.tblEmployee e
      WHERE @IdsEmp LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %' -- Новый перечень исполнителей (текущий отдел)
      OR
      (@IdCDeptS LIKE '% ' + CONVERT(VARCHAR(5), e.IdODept) + ' %'
      AND @idCEmpS LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %'); -- список исполнителей из других отделов

    -- Составить список отделов по составу имполнителей
    INSERT INTO @tDept
      SELECT DISTINCT
        d.IdDept
       ,d.sNameDept
      FROM dbo.tblEmployee e
      INNER JOIN dbo.tblDept d
        ON d.IdDept = e.IdODept
      WHERE @IdsEmp LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %'
      OR (@IdCDeptS LIKE '% ' + CONVERT(VARCHAR(5), e.IdODept) + ' %'
      AND @idCEmpS LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %');

  END
  ELSE -- в остальных случаях
  BEGIN
    -- Выбираем список исполнителей текущего этапа, если он создан
    SELECT
      @idCEmpS = a.IdsEmp
    FROM dbo.tAppointment a
    WHERE a.IdODoc = @IdDocIn
    AND a.IdOTypeApp = @IdTypeApp;

    --прибавить к списку ИД текущего прользователя
    SET @idCEmpS = @idCEmpS + ' ' + @IdEmp + ' ';

    -- добавляем в таблицу новый список пользователей
    INSERT INTO @tEmp
      SELECT
        e.IdEmployee
       ,e.FullName
      FROM dbo.tblEmployee e
      WHERE @idCEmpS LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %';

    -- Добавляем в таблицу новый список отделов
    INSERT INTO @tDept
      SELECT DISTINCT
        d.IdDept
       ,d.sNameDept
      FROM dbo.tblEmployee e
      INNER JOIN dbo.tblDept d
        ON d.IdDept = e.IdODept
      WHERE @idCEmpS LIKE '% ' + CONVERT(VARCHAR(5), e.IdEmployee) + ' %';

  END

  --Если этап 6 (завершено), устанавливаем дату завершения локумента
  IF @IdTypeApp = 6
    UPDATE dbo.tblDocIn
    SET DateEnd = @DateEtap
    WHERE IdDocIn = @IdDocIn;

  -- Создаем курсор по списку пользователей
  DECLARE curEmp CURSOR FOR SELECT
    *
  FROM @tEmp;

  OPEN curEmp;

  -- очищаем переменную со списком ИД пользователей (она была использована на предыдущих этапах)
  SET @idCEmpS = '';

  --перебираем записи таблицы
  FETCH NEXT FROM curEmp INTO @IdCEmp, @CEmp;

  WHILE @@FETCH_STATUS = 0
  BEGIN
  SET @CEmpS = @CEmpS + '  ' + @CEmp;
  SET @idCEmpS = @IdCEmpS + ' ' + @idCEmp;
  FETCH NEXT FROM curEmp INTO @IdCEmp, @CEmp;
  END

  CLOSE curEmp;
  DEALLOCATE curEmp;

  SET @idCEmpS = @idCEmpS + ' ';
  SET @CEmpS = REPLACE(LTRIM(@CEmpS), '  ', ', ');


  --
  DECLARE curDept CURSOR FOR SELECT
    *
  FROM @tDept;
  OPEN curDept;

  SET @IdCDeptS = '';
  FETCH NEXT FROM curDept INTO @IdCDept, @CDept;
  WHILE @@FETCH_STATUS = 0

  BEGIN
  SET @IdCDeptS = @IdCDeptS + ' ' + @IdCDept;
  SET @CDeptS = @CDeptS + ' ' + @CDept;
  FETCH NEXT FROM curDept INTO @IdCDept, @CDept;
  END
  CLOSE curDept;
  DEALLOCATE curDept;

  SET @IdCDeptS = @IdCDeptS + ' ';
  SET @CDeptS = REPLACE(LTRIM(@CDeptS), ' ', ', ');
  -- ===========================================================================================
  -- Попытка добавить этап
  BEGIN TRY
    INSERT INTO dbo.tAppointment (IdODoc, IdOEmp, IdODept, IdOTypeApp, Depts, IdsDept, Emps, IdsEmp)
      VALUES (@IdDocIn, @IdEmp, @idDept, @IdTypeApp, @CDeptS, @IdCDeptS, @CEmpS, @idCEmpS);
  END TRY
  -- Если запись этапа существует
  BEGIN CATCH
    -- Наити идентификатор
    SELECT
      @IdApp = a.IdAppointment
    FROM dbo.tAppointment a
    WHERE a.IdODoc = @IdDOcIn
    AND a.IdOTypeApp = @IdTypeApp;
    -- отредактировать запись
    UPDATE dbo.tAppointment
    SET IdODoc = @IdDocIn
       ,Depts = @CDeptS
       ,IdsDept = @IdCDeptS
       ,Emps = @CEmpS
       ,IdsEmp = @idCEmpS
    WHERE IdAppointment = @IdApp;
  END CATCH

END
