1. set configurations 
`spark.conf.set("spark.sql.streaming.stateStore.providerClass", "com.databricks.sql.streaming.state.RocksDBStateStoreProvider")`
`spark.conf.set("spark.sql.shuffle.partitions", 16)`
2. read schema
```py
SchemaRawDLDisputeAPI = spark.read.text(strSchemaPath).collect()
dictSchemaRawDLDisputeAPI = ast.literal_eval("".join([line.value for line in SchemaRawDLDisputeAPI]))
structSchemaRawDLDisputeAPI = StructType.fromJson(dictSchemaRawDLDisputeAPI)
```

3. define `upsertToDelta(microBatchOutputDF, batchId)` :
Structured Streaming extends this concept to streaming applications by treating a stream as an unbounded, continuously appended table

_incrementalization_: Structured Streaming figures out what state needs to be maintained to update the result each time a record arrives

|![[Pasted image 20210926231134.png]]|
|:--:|
| Figure 8-4. The Structured Streaming processing model|

## output modes

* [[Append Mode]]
* [[Update mode]]
* [[Complete Mode]]

## [[Streaming Query]]
