# Functions
`NOW()` current date and time
`DATE()` convert datetime to date
`INTERVAL 7 DAY` to do the date aggregations

### weekday / day of the week
`DAYOFWEEK()` returns number
`DAYNAME()` returns formal name such as `Monday`

#### date calculation
`DATE_SUB(date, INTERVAL expr unit)` ~ `SUBDATE(date, INTERVAL expr unit)`
`DATE_ADD(date, INTERVAL expr unit)` ~ `ADDDATE(date, INTERVAL expr unit)`

## get today's date
`CURDATE()` = `DATE(NOW())` = `CURRENT_DATE`

 ## string <-> timestamp conversion
`from_unixtime(unix_timestamp(FX.ReportTimestamp, 'yyyyMMddHHmmss'))`