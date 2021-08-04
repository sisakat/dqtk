-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE FUNCTION [dq].[letter]
(
    @input char
)
RETURNS bit
AS
BEGIN
    if (ascii(@input)>=65 and ascii(@input)<=90) 
         or (ascii(@input)>=97 and ascii(@input)<=122) begin
        return 1
    end
    return 0
END
GO