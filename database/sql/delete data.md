Delete is a [[DML]] command whereas truncate is [[DDL]] command.

* Truncate can be used to delete the entire data of the table without maintaining the integrity of the table. 

* Delete statement can be used for deleting the specific data. With delete command we can’t bypass the integrity enforcing mechanisms.

  
Sr. No.  |Key  |Delete  |Truncate  
--|--|--|--
1|Basic |It is used to delete specific data |It is used to delete the entire data of the table 
2| Where clause |We can use with where clause |It can’t be used with where clause 
3|Locking |It locks the table row before deleting the row |It locks the entire table 
4|Rollback |We can rollback the changes.|We can’t rollback the changes 
5|Performance|It is slower than truncate |It is faster than delete 

### Example of Truncate and Delete

```sql
//TRUNCATE Query 
TRUNCATE TABLE tableName; 

//Delete 
DELETE FROM tableName WHERE condition;
```