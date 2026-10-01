CREATE FUNCTION [dbo].[fnInitial]
--DECLARE
	(@Name varchar(100))
RETURNS varchar(100)
AS
BEGIN
	DECLARE
	@Name1 varchar(100)
	,@Name2 varchar(1)
	,@Name3 varchar(1)
	,@EndLoc int
	,@StartLoc2 int
	,@EndLoc2 int
	,@Result varchar(100)

	SET @Name = LTRIM(RTRIM(@Name))

	SET @EndLoc = CHARINDEX(' ', @Name, 1) - 1
	IF @EndLoc = -1
		SET @Result = @Name
	ELSE
		BEGIN
			SET @Name1 = SUBSTRING(@Name, 1, @EndLoc)

			SET @Name = SUBSTRING(@Name, @EndLoc + 2,100)
			SET @EndLoc = CHARINDEX(' ', @Name, 1) - 1
				IF @EndLoc = -1
					BEGIN
						SET @Name2 = @Name
						SET @Result = @Name1 + ' ' + @Name2 + '. '
					END
			ELSE
				BEGIN
					SET @Name2 = SUBSTRING(@Name, 1, @EndLoc)

					SET @Name3 = SUBSTRING(@Name, @EndLoc + 2,100)
						SET @Result = @Name1 + ' ' + @Name2 + '. ' + @Name3 + '. '
				END
		END
	RETURN @Result
END
