# T-SQL Dynamic Query Toolkit
This little library consists of several functions in T-SQL aimed
to help you write dynamic queries using real parameter names.

## Usage

### DqApply
The following SQL snippet demonstrates how to use the scalar-valued function
`dq_apply` to create dynamic queries.

```sql
declare @myVariable nvarchar(30) = 'test'
declare @sql nvarchar(max) =
	'select * from openquery(linked_server, ''
		select * from tbl where x = @myVariable
	'' ';
set @sql = dq.apply(@sql, '@myVariable', @myVariable)
```

The resulting query looks like this - it recognizes the needed quotation characters:

```sql
select * from openquery(linked_server, '
	select * from tbl where x = ''test''
	')
```

### Linked Server Execution
The following SQL snippet shows an easy way of executing linked server queries:

```sql
exec dq.sp_query_linked_server 'linked_server_name', 
	'select * from anytable where x = ?, y = ?', 
	'Parameter value for x',
	'Parameter value for y'
```