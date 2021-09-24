
**The clustered index will be automatically created when the primary key is defined**

> Clustered indexes are the unique index per table that uses the primary key to organize the data that is within the table. The clustered index ensures that the <font color = 'orange'>primary key is stored in increasing order</font>, which is also the order the table holds in memory.

-   Clustered indexes do not have to be explicitly declared.
-   Created when the table is created.
-   Use the primary key sorted in ascending order.


```sql
CREATE TABLE friends (id INT PRIMARY KEY, name VARCHAR, city VARCHAR);
```

