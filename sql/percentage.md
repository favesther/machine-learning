#cast
#percentage
hw3-q3
> For each origin city, find the percentage of non-canceled departing flights shorter than 3 hours.
(That is, compute number of non-canceled departing flights shorter than 3 hours / number of non-canceled departing flights * 100%, for each origin city.)
* Name the output columns origin_city and percentage 
* Order by percentage value, ascending.
* Be careful to handle cities without any flights shorter than 3 hours.
* Please report 0 as the result for those cities.
* (Hint: if your solution returns NULL for those cities, find a way to replace NULL with 0.
* Consider using a SQL CASE clause.)
* Report percentages as percentages not decimals (e.g., report 75.25 rather than 0.7525).
[Output relation cardinality: 327]

```sql
select f2.origin_city as origin_city, cast((select count(*) as number
                                            from FLIGHTS as f1
                                            where f1.actual_time < 180
                                            and f1.origin_city = f2.origin_city
                                            group by f1.origin_city) as float) * 100 /count(*) as percentage
from FLIGHTS as f2
group by f2.origin_city;
```
