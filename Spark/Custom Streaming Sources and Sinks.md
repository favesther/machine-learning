read and write to storage systems that do not have built in support in [[Structured Streaming]]

# `foreachBatch()`
* allows arbitrary operations and custom logic on the output of each micro-batch
* allows you to specify a function that is executed on the output of every micro-batch of a streaming query

Parameters:
	* a DataFrame or Dataset that has the output of a micro-batch
	* the unique identifier of the micro-batch
	
	
## example
use the connector’s batch DataFrame support to write the output of each batch (i.e., updated word counts) to Cassandra

<font color = 'orange'><b>StructuredStreamingStaging</b></font>

```py
hostAddr = "<ip address>"
keyspaceName = "<keyspace>"
tableName = "<tableName>"

spark.conf.set("spark.cassandra.connection.host", hostAddr)

def writeCountsToCassandra(updatedCountsDF, batchId):
    # Use Cassandra batch data source to write the updated counts
    (updatedCountsDF
      .write
      .format("org.apache.spark.sql.cassandra")
      .mode("append")
      .options(table=tableName, keyspace=keyspaceName)
      .save())
      
streamingQuery = (counts
  .writeStream
  .foreachBatch(writeCountsToCassandra)
  .outputMode("update")
  .option("checkpointLocation", checkpointDir)
  .start())
```

## usage of `foreachbatch()`

* Reuse existing batch data sources
	* to write the output of streaming queries
* Write to multiple locations
	* to avoid recomputations, cache the `batchOutputDataFrame`, write it to multiple locations, and then uncache it
		```py
		def writeCountsToMultipleLocations(updatedCountsDF, batchId):
			updatedCountsDF.persist()
			updatedCountsDF.write.format(...).save()  # Location 1
			updatedCountsDF.write.format(...).save()  # Location 2
			updatedCountsDF.unpersist()
		```

* Apply additional DataFrame operations


# `foreach()`
allows custom write logic on every row

