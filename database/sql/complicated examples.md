#### 571. find median
```sql
select avg(Number) as median

from (

 select n.*,

 @r_down:= (@r_up) as rank_down, 

 @r_up:=@r_up + n.Frequency as rank_up

 from Numbers n, (select @r_down:=0, @r_up:=0) t 

 order by n.Number

) f1, (

 select ceil(sum(Frequency)/2) center, if(sum(Frequency)%2 =0,1,0) as id

 from Numbers

) f2

where f1.rank_down < f2.center + id and f1.rnk >= f2.center
```
#### [262. Trips and Users] ()
```sql
# Write your MySQL query statement below
select t.Request_at Day, 
round(count(if(t.Status like 'cancelled%',1,null))/count(t.Id),2) 'Cancellation Rate'
from Trips t
inner join Users u on
u.Users_Id = t.Client_Id and u.Role = 'client' and u.Banned = 'No'
inner join Users y on 
y.Users_Id = t.Driver_Id and y.Role = 'driver' and y.Banned = 'No'
where t.Request_at between '2013-10-01' and '2013-10-03'
group by t.Request_at
order by t.Request_at;
```

#### [601. Human Traffic of Stadium](https://leetcode-cn.com/problems/human-traffic-of-stadium/)
```sql
# Write your MySQL query statement below

with h as(

 select *,id - row_number() over(order by id) as ind

 from Stadium

 where people >= 100

)

select id, visit_date, people

from h

where ind in (

 select ind

 from h

 group by ind

 having count(ind)>=3

)
```