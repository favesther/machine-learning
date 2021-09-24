```sql
SELECT w2.Id

FROM Weather w1

join Weather w2

on to_days(w1.recordDate) = to_days(w2.recordDate) - 1

AND w1.Temperature < w2.Temperature
```