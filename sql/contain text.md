```sql
-- start from certain text
select a.column not like 'text%'
-- contain in the middle 
select a.column not like '%text%'
  
-- in clause
-- subquery
SELECT a FROM x WHERE x.b NOT IN (SELECT b FROM y);
-- predefined list
SELECT a FROM x WHERE x.b NOT IN (1, 2, 3, 6);
```