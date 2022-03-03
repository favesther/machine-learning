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
#### [1225. Report Contiguous Dates](https://leetcode-cn.com/problems/report-contiguous-dates/)
```sql
with a as (
 select "failed" as period_state, fail_date as event_date
 from Failed 
 union all
 select "succeeded" as period_state, success_date as event_date
 from Succeeded 
), b as (
 select *,
 rank() over (partition by period_state order by event_date) as rnk,
 row_number() over (order by event_date) as rownum
 from a
 where event_date between "2019-01-01" and "2019-12-31"
)
select period_state, min(event_date) as start_date, max(event_date) as end_date
from b
group by period_state, rownum - rnk
order by start_date
```
#### [1651. Hopper Company Queries III](https://leetcode-cn.com/problems/hopper-company-queries-iii/)
```sql
with recursive n(m) as(
 select 1
 union all
 select m + 1 from n
 where m < 12
), t as (
select n.m, 
 ifnull(sum(ride_distance),0) as m_distance, 
 ifnull(sum(ride_duration),0) as m_duration 
from n
left join Rides r 
on year(r.requested_at) = 2020 and month(r.requested_at) = n.m
left join AcceptedRides a 
on a.ride_id = r.ride_id
group by n.m
order by n.m
)
select m as month , 
 round(sum(m_distance) over w / 3 ,2) as average_ride_distance,
 round(sum(m_duration) over w / 3 ,2) as average_ride_duration 
from t
WINDOW w AS (order by m rows between current row and 2 following)
limit 10;
```