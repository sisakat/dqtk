-- =============================================
-- Author:		Stefan Isak
-- Create date: 03.08.2021
-- Description:	Dq Apply
-- =============================================
CREATE FUNCTION [dbo].[dq_apply_quoted]
(
	@query nvarchar(max),
	@parameter nvarchar(30),
	@value nvarchar(max),
	@quote bit = 0
)
RETURNS nvarchar(max)
AS
BEGIN
	set @parameter = replace(@parameter, '@', '')
	declare @quotations int = 0
	select @quotations = surrounded_quotes
	from dbo.dq_extract(@query, '@')
	where variable_name = @parameter;
	declare @quotes nvarchar(30) = 
		case when @quote = 1 
			then replicate('''', case when @quotations = 0 
							     then 1 
								 else isnull(@quotations, 1) * 2 end
						  ) 
			else '' end
	return replace(@query, '@' + @parameter, @quotes + @value + @quotes)
END
GO