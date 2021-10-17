```sql
left join Orders o on o.CustomerId = c.Id where o.CustomerId is Null
```


hw3-q6
List all cities that cannot be reached from Seattle through a direct flight
and cannot be reached from Seattle with one stop (i.e., with any two flights that go through an intermediate city).
* Assume all cities to be the collection of both origin_city and dest_city.
* Warning: this query might take a while to execute.
* We will learn about how to speed this up in lecture.
* Name the output column city. Order the output ascending by city.
[Output relation cardinality: 4]

```sql
select distinct f.dest_city as city
from Flights as f
where f.origin_city!='Seattle WA' and
      f.dest_city not in (
    select distinct f2.dest_city
    from Flights as f1, Flights as f2
    where f1.origin_city='Seattle WA' and
          f1.dest_city=f2.origin_city and
          f2.dest_city!='Seattle WA' /*tip: Seattle cannot be reached from Seattle as well*/
    ) ;
```