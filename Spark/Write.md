# Writing to files
```py
outputDir = ...
checkpointDir = ...
resultDF = ...

StreamingQuery = (resultDF.writeStream
	.format("parquet")
	.option("path", outputDir) # or directly use `.start(outputDir)`
	.option("checkpointLocation", checkpointDir)
	.start()	
)
```

# Write to Kafka

Table 8-2. Schema of DataFrame that can be written to the Kafka sink

Column name|Column type|Description
:--:|:--:|:--
`key`(optional)|`string` or `binary`|If present, the bytes will be written as the Kafka record key; otherwise, the key will be empty.
`value` (required)|`string` or `binary`|The bytes will be written as the Kafka record value.
`topic` (required only if `"topic"` is not specified as option)|`string`|If `"topic"` is not specified as an option, this determines the topic to write the key/value to. This is useful for fanning out the writes to multiple topics. If the `"topic"` option has been specified, this value is ignored.

```py
counts = ... # DataFrame[word: string, count: long]
streamingQuery = (counts
  .selectExpr(
    "cast(word as string) as key", 
    "cast(count as string) as value")
  .writeStream
  .format("kafka")
  .option("kafka.bootstrap.servers", "host1:port1,host2:port2")
  .option("topic", "wordCounts")
  .outputMode("update")
  .option("checkpointLocation", checkpointDir)
  .start())
```