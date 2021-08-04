-- =============================================
-- Author:      Stefan Isak
-- Create date: 03.08.2021
-- =============================================
CREATE PROCEDURE [dq].[sp_query_linked_server]
    @linked_server nvarchar(30),
    @query nvarchar(max),
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
    declare @sql nvarchar(max) =
        'select * from openquery(' + @linked_server + ', ''' + replace(@query, '''', '''''') + ''')'
    exec sp_apply @sql output, @p1,
        @p2,
        @p3,
        @p4,
        @p5,
        @p6,
        @p7,
        @p8,
        @p9,
        @p10,
        @p11,
        @p12,
        @p13,
        @p14,
        @p15,
        @p16,
        @p17,
        @p18,
        @p19,
        @p20,
        @p21,
        @p22,
        @p23,
        @p24,
        @p25,
        @p26,
        @p27,
        @p28,
        @p29,
        @p30
    exec (@sql)
END
GO