# use row
```py
from pyspark.sql import Row
rows = [Row("Matei Zaharia", "CA"), Row("Reynold Xin", "CA")] 
authors_df = spark.createDataFrame(rows, ["Authors", "State"]) 
```