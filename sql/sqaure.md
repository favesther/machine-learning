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