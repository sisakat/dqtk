-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE FUNCTION [dq].[apply]
(
    @query nvarchar(max),
    @parameter nvarchar(30),
    @value nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
    return dq.apply_quoted(@query, @parameter, @value, 1)
END
GO