# T-SQL Dynamic Query Toolkit
This little library consists of several functions in T-SQL aimed
to help you write dynamic queries using real parameter names.

## Usage
The following SQL snippet demonstrates how to use the scalar-valued function
`dq_apply` to create dynamic queries.

```sql
declare @myVariable nvarchar(30) = 'test'
declare @sql nvarchar(max) =
	'select * from openquery(linked_server, ''
		select * from tbl where x = @myVariable
	'' ';
set @sql = dbo.dq_apply(@sql, '@myVariable', @myVariable)
```

The resulting query looks like this - it recognizes the needed quotation characters:

```sql
select * from openquery(linked_server, '
	select * from tbl where x = ''test''
	')
```