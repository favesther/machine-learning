* which method of search from the query plan was chosen
* how long the planning and execution of the query took
  
```sql
EXPLAIN ANALYZE SELECT * FROM friends WHERE name = 'Blake';
```