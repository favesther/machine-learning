# Explode and Collect
* explode(values), which creates a new row (with the id) for each element (value) within values
* collect_list() returns a list of objects with duplicates

```sql
-- In SQL 
SELECT id, collect_list(value + 1) AS values 
FROM (SELECT id, EXPLODE(values) AS value 
		FROM table) x 
GROUP BY id
```

# [[transform()]]
# [[filter()]]
# [[exists()]]
