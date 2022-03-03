TO_DAYS(t1.Date)

## conversion
### string to date
`str_to_date('2020-1','%Y-%m')`
`date_format(str_to_date(concat('2020-',1),'%Y-%m'),'%Y-%m')` -> 2020-01 (date)