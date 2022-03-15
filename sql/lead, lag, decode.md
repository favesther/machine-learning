### lead, lag
前一个，后一个
```sql
SELECT
         n,
         LAG(n, 1, null)      OVER w AS 'lag',
         LEAD(n, 1, null)     OVER w AS 'lead',
         n + LAG(n, 1, null)  OVER w AS 'next_n',
         n + LEAD(n, 1, null) OVER w AS 'next_next_n'
FROM fib
WINDOW w AS (ORDER BY n);
```
	   

n | lag | lead | next_n | next_next_n
:--:|:--:|:--:|:--:|:--:
1 |    null |    1 |      1 |2
 1 |    1 |    2 |      2 |3
 2 |    1 |    3 |      3 |5 
 3 |    2 |    5 |      5 |8 
 5 |    3 |    8 |      8 |13 
 8 |    5 |    null |     13 |8 
 

#### [180. Consecutive Numbers](https://leetcode-cn.com/problems/consecutive-numbers/)
```sql
	select distinct num as ConsecutiveNums 
	from(
		 select *,
				 lag(num, 1, null) over w as lag_num,
				 lead(num, 1, null) over w as lead_num
		 from Logs
		 WINDOW w as (order by id)
	) as t
	where t.num = t.lag_num and t.num = t.lead_num
```

#### [2142. The Number of Passengers in Each Bus I](https://leetcode-cn.com/problems/the-number-of-passengers-in-each-bus-i/)

```sql 

with a as(
	select *, 
			lag(arrival_time,1,0) over (order by arrival_time) as last_bus
	from Buses
)
select bus_id, count(passenger_id) as passengers_cnt 
from a
left join Passengers p 
	on p.arrival_time > a.last_bus and p.arrival_time <= a.arrival_time 
group by a.bus_id
order by 1```