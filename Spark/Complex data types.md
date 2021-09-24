# arrays
# maps
# struct
> A #struct is similar to a case class: it stores a set of key-value pairs, with a fixed set of keys. If we convert an RDD of a case class containing nested case classes to a DataFrame, Spark will convert the nested objects to a struct.

## e.g.
```py
from pyspark.sql.types import *
schema = StructType([StructField("celsius", ArrayType(IntegerType()))])

t_list = [[35, 36, 32, 30, 40, 42, 38]],[[31, 32, 34, 55, 56]]
t_c = spark.createDataFrame(t_list, schema)
t_c.createOrReplaceTempView("tC")

# show the DataFrame
t_c.show()
```

Here’s the output: 

celsius|-
:--:|-
[35, 36, 32, 30, 40, 42, 38]|
[31, 32, 34, 55, 56]|
