> Indexing makes columns faster to query by creating pointers to where data is stored within a database.

## Definition

1. [[clustered indexes]]
2. [[non-clustered indexes]]

Both clustered and non-clustered indexes are stored and searched as B-trees, a data structure similar to a [binary tree](https://en.wikipedia.org/wiki/Binary_tree).


## **create indexes**
[[create indexes]]

## **search indexes**
[[search indexes]]

## **When not to use Indexes**

When data is written to the database, the original table (the clustered index) is updated first and then all of the indexes off of that table are updated. Every time a write is made to the database, the indexes are unusable until they have updated. If the database is constantly receiving writes then the indexes will never be usable. This is why indexes are typically applied to databases in data warehouses that <font color = 'pink'>get new data updated on a scheduled basis(off-peak hours)</font> and not production databases which might be <font color = 'jade'>receiving new writes all the time</font>.

NOTE: The [newest version of Postgres (that is currently in beta](https://www.postgresql.org/about/news/1943/)) will allow you to query the database while the indexes are being updated.

