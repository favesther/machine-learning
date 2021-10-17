
3. Find origin cities that only serve flights shorter than 3 hours.
Name the output column city and sort them alphabetically. List each city only once in the result.
[Output relation cardinality: 109]


```sql
select distinct origin_city as city
from Flights
where origin_city not in (select distinct origin_city
from Flights
where actual_time>=3*60);
```


5. List all cities that cannot be reached from Seattle though a direct flight
but can be reached with one stop (i.e., with any two flights that go through an intermediate city).
Do not include Seattle as one of these destinations (even though you could get back with two flights).
Name the output column city. Order the output ascending by city.
[Output relation cardinality: 256]*/

```sql
select distinct f2.dest_city as city
from Flights as f1,
     Flights as f2
where f1.dest_city = f2.origin_city and
      f1.origin_city='Seattle WA' and
      f2.dest_city!='Seattle WA' and
      f2.dest_city not in (select distinct f1.dest_city from Flights as f1 where f1.origin_city='Seattle WA')
order by city asc;
```


	
7. List the names of carriers that operate flights from Seattle to San Francisco CA.
Name the output column carrier.
Return each carrier's name once.
Order the output ascending by carrier.
[Output relation cardinality: 4]*/

```sql
select c.name as carrier
from (select distinct f1.carrier_id
      from Flights as f1
      where f1.origin_city = 'Seattle WA' and f1.dest_city = 'San Francisco CA') as f
   , Carriers as c
where f.carrier_id=c.cid;
```

