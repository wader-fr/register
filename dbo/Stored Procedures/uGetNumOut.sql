-- Batch submitted through debugger: SQLQuery2.sql|7|0|C:\Users\roman.CGIE\AppData\Local\Temp\~vs1F43.sql


CREATE PROCEDURE [dbo].[uGetNumOut] 
--	declare 
	@IdDocOut bigint = 80338
AS
begin
	declare @IdTypeDoc int = null
			,@IdGroup int = null
			,@Year nchar(4)
			,@NumOut int;

	select @IdTypeDoc = do.IdOTypeDocOut, @Year =  do.YearOut, @IdGroup =  dto.AutoNumGroup, @NumOut = do.ANumDocOut
	from dbo.tDocOut do
		inner join dbo.tblDocTypeOut dto on dto.IdDocTypeOut = do.IdOTypeDocOut
	where do.IdDocOut = @IdDocOut
	begin tran
	if @NumOut is null
		begin
			select @NumOut = isnull(max(do.ANumDocOut), 0) + 1
			from dbo.tDocOut do
				inner join dbo.tblDocTypeOut dto on dto.IdDocTypeOut = do.IdOTypeDocOut
			where do.YearOut = @Year and (do.IdOTypeDocOut = @IdTypeDoc or dto.AutoNumGroup = @IdGroup)
		
			if @NumOut is not null
					update dbo.tDocOut
					set ANumDocOut = @NumOut
					where IdDocOut = @IdDocOut
		end
	commit tran
end
