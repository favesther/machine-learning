# return non-null
The SQL Coalesce function evaluates the arguments in order and always returns _first non-null_ value from the defined argument list.

`SELECT COALESCE (NULL,'A','B')`
results: `'A'`

# concat string
`COALESCE('A','B')`
results: `AB`