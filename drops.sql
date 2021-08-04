IF object_id(N'dq_apply', N'FN') is not null
    drop function dq_apply
GO

IF object_id(N'dq_apply_quoted', N'FN') is not null
    drop function dq_apply_quoted
GO

IF object_id(N'dq_extract', N'TF') is not null
    drop function dq_extract
GO

IF object_id(N'dq_letter', N'FN') is not null
    drop function dq_letter
GO

IF object_id(N'dq_quote', N'FN') is not null
    drop function dq_quote
GO