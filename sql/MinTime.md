hw3-q2
For each origin city, find the destination city (or cities) with the shortest direct flight for non-canceled flights.
By direct flight, we mean a flight with no intermediate stops.
Judge the shortest flight in time, not distance.
Name the output columns origin_city, dest_city, and time representing the the flight time between them.
Do not include duplicates of the same origin/destination city pair.
Order the result by time ascending and then origin_city ascending (i.e. alphabetically).
[Output relation cardinality: 339 rows]

```sql
/*cities that are not direct*/
select distinct f1.origin_city
from Flights f1, Flights f2
where f2.dest_city=f1.origin_city and f1.carrier_id=f2.carrier_id and f1.flight_num=f2.flight_num


/*run time: 1m40s 849ms*/
with MinTime as (
    select origin_city, min(actual_time) as shortest
    from Flights
    where actual_time>0 /*all non-cancelled flights show actual time equals zero*/
    group by origin_city
)
select distinct F.origin_city, F.dest_city, F.actual_time as time
from MinTime as MT, Flights as F
where MT.origin_city=F.origin_city and
      F.actual_time=MT.shortest
order by time, F.origin_city asc;
```