```sql
id - row_number
```

#### [601. Human Traffic of Stadium](https://leetcode-cn.com/problems/human-traffic-of-stadium/)
display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
```sql
select id, visit_date, people
from (select *, 
             count(id) over (partition by consecutive_mark) as cnt
      from (select *,
                   id- row_number() over (order by id) as consecutive_mark
            from Stadium
            where people >= 100
            ) a
      )b
where cnt>=3
order by visit_date
```