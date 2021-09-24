## group by id, longest consecutive days
use dense_rank() & subdate() 
 
```sql
select t.id, name
from (select *,dense_rank() over (partition by id order by login_date) rnk
from Logins) t
left join Accounts a on t.id = a.id
group by t.id, subdate(login_date, interval t.rnk day)
having count(distinct login_date) >= 5
```

## group by date
subquery and #datediff 

```sql
select submission_date, (

 select count(distinct s2.hacker_id) 

 from submissions s2

 where s2.submission_date = s1.submission_date and

 (

 select count(distinct s3.submission_date) 

 from submissions s3 

 where s3.hacker_id = s2.hacker_id and 

 s3.submission_date < s1.submission_date

 ) = datediff(s1.submission_date,'2016-03-01')

), (

 select hacker_id from submissions s2 

 where s2.submission_date = s1.submission_date

 group by hacker_id order by count(submission_id) desc, hacker_id asc limit 1

) as top_hacker, (

 select name from hackers where hacker_id = top_hacker)

from (select distinct submission_date from submissions) s1

group by submission_date;
```

## duration
```sql
select start_date, end_date
from(
	select start_date, min(end_date) end_date
	from 
		(select start_date from Projects 
		where start_date not in (select distinct end_date from Projects)) s,
		(select end_date from Projects 
		where end_date not in (select distinct start_date from Projects)) e
	where s.start_date<e.end_date
	group by s.start_date
	order by 1) t
order by datediff(end_date, start_date), 1
```