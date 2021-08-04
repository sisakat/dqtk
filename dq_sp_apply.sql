-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE PROCEDURE [dbo].[dq_sp_apply]
    @query nvarchar(max) OUTPUT,
    @p1 nvarchar(max) = NULL,
    @p2 nvarchar(max) = NULL,
    @p3 nvarchar(max) = NULL,
    @p4 nvarchar(max) = NULL,
    @p5 nvarchar(max) = NULL,
    @p6 nvarchar(max) = NULL,
    @p7 nvarchar(max) = NULL,
    @p8 nvarchar(max) = NULL,
    @p9 nvarchar(max) = NULL,
    @p10 nvarchar(max) = NULL,
    @p11 nvarchar(max) = NULL,
    @p12 nvarchar(max) = NULL,
    @p13 nvarchar(max) = NULL,
    @p14 nvarchar(max) = NULL,
    @p15 nvarchar(max) = NULL,
    @p16 nvarchar(max) = NULL,
    @p17 nvarchar(max) = NULL,
    @p18 nvarchar(max) = NULL,
    @p19 nvarchar(max) = NULL,
    @p20 nvarchar(max) = NULL,
    @p21 nvarchar(max) = NULL,
    @p22 nvarchar(max) = NULL,
    @p23 nvarchar(max) = NULL,
    @p24 nvarchar(max) = NULL,
    @p25 nvarchar(max) = NULL,
    @p26 nvarchar(max) = NULL,
    @p27 nvarchar(max) = NULL,
    @p28 nvarchar(max) = NULL,
    @p29 nvarchar(max) = NULL,
    @p30 nvarchar(max) = NULL
AS
BEGIN
    declare @quotations int = 0
    declare @start_idx int = 0
    declare @end_idx int = 0
    declare @offset int = 0
    declare @quotes nvarchar(30)
    declare @result nvarchar(max)
    declare @i int = 0

    -- cursor for each variable occurence in the string
    declare cur cursor read_only for
        select surrounded_quotes, start_idx, end_idx
        from dbo.dq_extract(@query, '?')
        order by start_idx asc
    
    open cur
    fetch next from cur into @quotations, @start_idx, @end_idx
    while @@FETCH_STATUS = 0 begin
        set @i = @i + 1
        set @quotes = 
                 replicate('''', case when @quotations = 0 
                                 then 1 
                                 else isnull(@quotations, 1) * 2 end
                          ) 
            
        -- compute the final value that should be replaced
        declare @value nvarchar(max)
        set @value =
            case
            when @i = 1 then @p1
            when @i = 2 then @p2
            when @i = 3 then @p3
            when @i = 4 then @p4
            when @i = 5 then @p5
            when @i = 6 then @p6
            when @i = 7 then @p7
            when @i = 8 then @p8
            when @i = 9 then @p9
            when @i = 10 then @p10
            when @i = 11 then @p11
            when @i = 12 then @p12
            when @i = 13 then @p13
            when @i = 14 then @p14
            when @i = 15 then @p15
            when @i = 16 then @p16
            when @i = 17 then @p17
            when @i = 18 then @p18
            when @i = 19 then @p19
            when @i = 20 then @p20
            when @i = 21 then @p21
            when @i = 22 then @p22
            when @i = 23 then @p23
            when @i = 24 then @p24
            when @i = 25 then @p25
            when @i = 26 then @p26
            when @i = 27 then @p27
            when @i = 28 then @p28
            when @i = 29 then @p29
            when @i = 30 then @p30
            end
        set @result = @quotes + @value + @quotes

        -- replace the original value
        set @query = stuff(@query, 
                        @start_idx + @offset, 
                        (@end_idx + @offset) - (@start_idx + @offset), 
                        replace(substring(@query, 
                                    @start_idx + @offset, 
                                    (@end_idx + @offset) - (@start_idx + @offset)), 
                            '?', 
                            @result)
                     )

        -- calculate an offset to the next index based on the new string
        set @offset = @offset + len(@result) - 1
        
        fetch next from cur into @quotations, @start_idx, @end_idx
    end
    close cur
    deallocate cur
END
GO