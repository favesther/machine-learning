```sql
select id, month, sum_salary as salary

from (select *,

 sum(salary) over (partition by id order by month range 2 preceding) as sum_salary,

 rank() over (partition by id order by month desc) as rnk

from Employee) a

where rnk > 1 

order by id, month desc
```