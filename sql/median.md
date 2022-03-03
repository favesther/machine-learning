#### [571. Find Median Given Frequency of Numbers](https://leetcode-cn.com/problems/find-median-given-frequency-of-numbers/)
Input: 
Numbers table:

| num | frequency|
:--:|:--:
|0|7|
| 1   | 1         |
| 2   | 3         |
| 3   | 1         |
Output: median= 0
```sql
select round(avg(num),1) as median

from (select *,

 sum(frequency) over (order by num) as sum_asc,

 sum(frequency) over (order by num desc) as sum_desc,

 sum(frequency) over () as total 

from Numbers 

order by num) a

where sum_asc >= total/2

and sum_desc >= total/2
```