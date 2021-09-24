> Non-clustered indexes are sorted references for a specific field, from the main table, that hold pointers back to the original entries of the table.

can be created after a table has been created and filled

Note: Non-clustered indexes are **not** new tables. Non-clustered indexes hold the field that they are responsible for sorting and a pointer from each of those entries back to the full entry in the table.

```sql
CREATE INDEX friends_name_asc ON friends(name ASC);
```