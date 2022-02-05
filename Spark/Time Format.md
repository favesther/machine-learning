```py
datetime.strptime("04-JAN-22 09.48.37.455631 AM -08:00",'%d-%b-%y %I.%M.%S.%f %p %z').date()
```

```py
from pyspark.sql.functions import udf
myFunction = udf(lambda x: datetime.strptime(x,'%d-%b-%y %I.%M.%S.%f %p'))
df_udmf.filter((col("UPLOADED_ON").like("%AM%")) | (col("UPLOADED_ON").like("%PM%"))).withColumn('Test', to_timestamp(myFunction(substring(col('UPLOADED_ON'),1,28)))).select('Test').display()
```
https://spark.apache.org/docs/latest/sql-ref-datetime-pattern.html