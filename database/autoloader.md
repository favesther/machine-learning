```scala
val crowdstrikeStream = spark.readStream .format("cloudFiles") 		.option("cloudFiles.format", "text") // text file doesn’t need schema 
.option("cloudFiles.region", "us-west-2")
.option("cloudFiles.useNotifications", "true")
.load(rawDataSource)
.withColumn("load_timestamp", current_timestamp())
.withColumn("load_date", to_date($"load_timestamp"))
.withColumn("eventType", from_json($"value", "struct", Map.empty[String, String])) .selectExpr("eventType.event_simpleName","load_date","load_timestamp", "value" ) .writeStream .format("delta") .option("checkpointLocation", checkPointLocation) .table("demo_bronze.crowdstrike")
```
