```py
import json
sc = spark.sparkContext
df = spark.read.json(sc.parallelize([str_schema]))
str_dict = str(df.schema.jsonValue())
```