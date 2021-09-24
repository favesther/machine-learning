```sql
update [table] 
set [column]= CHAR(ASCII('f') + ASCII('m') - ASCII([column]));
```