-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE FUNCTION [dq].[apply_quoted]
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
    declare @start_idx int = 0
    declare @end_idx int = 0
    declare @offset int = 0
    declare @quotes nvarchar(30)
    declare @result nvarchar(max)

    -- cursor for each variable occurence in the string
    declare cur cursor read_only for
        select surrounded_quotes, start_idx, end_idx
        from dq.extract(@query, '@')
        where variable_name = @parameter
        order by start_idx asc
    
    open cur
    fetch next from cur into @quotations, @start_idx, @end_idx
    while @@FETCH_STATUS = 0 begin
        set @quotes = case when @quote = 1 
            then replicate('''', case when @quotations = 0 
                                 then 1 
                                 else isnull(@quotations, 1) * 2 end
                          ) 
            else '' end
            
        -- compute the final value that should be replaced
        set @result = @quotes + @value + @quotes

        -- replace the original value
        set @query = stuff(@query, 
                        @start_idx + @offset, 
                        (@end_idx + @offset) - (@start_idx + @offset), 
                        replace(substring(@query, 
                                    @start_idx + @offset, 
                                    (@end_idx + @offset) - (@start_idx + @offset)), 
                            '@' + @parameter, 
                            @result)
                     )

        -- calculate an offset to the next index based on the new string
        set @offset = @offset + len(@result) - len(@parameter) - 1
        
        fetch next from cur into @quotations, @start_idx, @end_idx
    end
    close cur
    deallocate cur
    return @query
END
GO