IF object_id(N'dq_extract', N'TF') is not null
	drop function dq_extract
GO

-- =============================================
-- Author:		Stefan Isak
-- Create date: 03.08.2021
-- Description:	Extract Variables
-- =============================================
CREATE FUNCTION [dbo].[dq_extract] 
(
	@input nvarchar(max),
	@startch char
)
RETURNS 
@variable_names TABLE 
(
	variable_name nvarchar(30),
	surrounded_quotes int
)
AS
BEGIN
	declare @i int = 0
	declare @curr char = ''
	declare @next char = ''
	declare @name nvarchar(30) = ''
	declare @start bit = 0
	declare @quote_count int = 0
	declare @curr_quotes int = 0

	while @i < len(@input)
	begin
		set @i = @i + 1
		set @curr = substring(@input, @i, 1)
		if @i+1 < len(@input) begin
			set @next = substring(@input, @i + 1, 1)
		end else begin 
			set @next = '' 
		end

		if dbo.dq_letter(@curr) = 0 and @start = 1 begin
			insert into @variable_names values (@name, @quote_count)
			set @start = 0
			set @name = ''
		end else if @start = 1 begin
			set @name = @name + @curr
		end
		if @curr = @startch and @start = 0 begin set @start = 1 end
		if @curr = '''' begin
			set @curr_quotes = @curr_quotes + 1
			if @next <> '''' begin 
				if @quote_count < @curr_quotes begin
					set @quote_count = @quote_count + 1 
				end else begin
					set @quote_count = @quote_count - 1
				end
				set @curr_quotes = 0
			end
		end
	end
	RETURN
END
GO