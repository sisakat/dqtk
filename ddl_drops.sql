IF object_id(N'dq.sp_query_linked_server', N'P') is not null
    drop procedure dq.sp_query_linked_server
GO

IF object_id(N'dq.sp_apply', N'P') is not null
    drop procedure dq.sp_apply
GO

IF object_id(N'dq.apply', N'FN') is not null
    drop function dq.apply
GO

IF object_id(N'dq.apply_quoted', N'FN') is not null
    drop function dq.apply_quoted
GO

IF object_id(N'dq.extract', N'TF') is not null
    drop function dq.extract
GO

IF object_id(N'dq.letter', N'FN') is not null
    drop function dq.letter
GO

IF object_id(N'dq.quote', N'FN') is not null
    drop function dq.quote
GO