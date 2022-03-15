#### [1336. Number of Transactions per Visit](https://leetcode-cn.com/problems/number-of-transactions-per-visit/)

```sql
with a as(
	select user_id, visit_date as date, 0 as amt
	from visits
	union all
	select user_id, transaction_date as date, amount as amt
	from transactions
),b as (
	select sum(amt>0) as cnt
	from a
	group by user_id, date)
select convert(c.n, UNSIGNED) as transactions_count, 
	   count(b.cnt) as visits_count
from (
	select 0 as n
	union all
	select (@x:= @x+1) as n from transactions,(select @x:=0) nums
) c
left join b on c.n = b.cnt
where c.n <= (select max(cnt) from b)
group by c.n
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
select period_state, 
		min(event_date) as start_date, 
		max(event_date) as end_date
from b
group by period_state, rownum - rnk
order by start_date
```