-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE FUNCTION [dbo].[dq_quote]
(
    @input nvarchar(max),
    @depth int
)
RETURNS nvarchar(max)
AS
BEGIN
    return replicate('''', @depth) + @input + replicate('''', @depth)
END
GO