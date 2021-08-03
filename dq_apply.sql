-- =============================================
-- Author:		Stefan Isak
-- Create date: 03.08.2021
-- Description:	Dq Apply
-- =============================================
CREATE FUNCTION [dbo].[dq_apply]
(
	@query nvarchar(max),
	@parameter nvarchar(30),
	@value nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
	return dbo.dq_apply_quoted(@query, @parameter, @value, 1)
END
GO