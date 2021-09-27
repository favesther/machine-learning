# Define 
(5 steps)
##  Define input sources `spark.readStream`

```py
# In Python
spark = SparkSession...
lines = (spark
  .readStream.format("socket")
  .option("host", "localhost")
  .option("port", 9999)
  .load())
```

## transform data
```py
# In Python
from pyspark.sql.functions import *
words = lines.select(split(col("value"), "\\s").alias("word"))
counts = words.groupBy("word").count()
```

two braod classes of data transformations:
* [[Stateless transformations]]
	* such as `select(), filter()`
* [[Stateful transformations]]
	* such as `count()`

## Define output sink and output mode
`DataFrame.writeStream` -> `DataStreamWriter` has additional methods to specify the following:
-   Output writing details (where and how to write the output)
	-   `format("console")` - the output streaming sink
-   Processing details (how to process data and how to recover from failures) what part of the updated output to write out after processing the new data
	- `outputMode("complete")`  - print to the console either the counts of all the words seen until now. [[outputMode]]
```py
# In Python
writer = counts.writeStream.format("console").outputMode("complete")
```

## Step 4: Specify processing details