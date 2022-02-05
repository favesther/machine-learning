# Databricks notebook source

# MAGIC %md

# MAGIC ###Dispute API

  

# COMMAND ----------

  

spark.conf.set("spark.sql.streaming.stateStore.providerClass", "com.databricks.sql.streaming.state.RocksDBStateStoreProvider")

spark.conf.set("spark.sql.shuffle.partitions", 16)

  

# COMMAND ----------

  

# MAGIC %run

# MAGIC "/Common Files/FunctionsShared"

  

# COMMAND ----------

  

import ast

from pyspark.sql.types import StructType

  

strSchemaPath = spark.sql("select SchemaPath from utility.ProcessDataConfiguration where Capability = 'Dispute'").collect()[0][0]

  

## Changed by Jimin Shin 9/30/2021

## Changed code to make this being able to run in dbc-shared-001 Jimin Shin 9/30/2021

SchemaRawDLDisputeAPI = spark.read.text(strSchemaPath).collect()

dictSchemaRawDLDisputeAPI = ast.literal_eval("".join([line.value for line in SchemaRawDLDisputeAPI]))

structSchemaRawDLDisputeAPI = StructType.fromJson(dictSchemaRawDLDisputeAPI)

  

# COMMAND ----------

  

from pyspark.sql.window import Window

from pyspark.sql.functions import from_json, row_number, desc

  

# Function to upsert `microBatchOutputDF` into Delta table using MERGE

def upsertToDelta(microBatchOutputDF, batchId):

 starttimestamp = spark.sql('SELECT current_timestamp()') 

 microBatchOutputDF.persist()

  

 # It requires to save ALL valid messages to the staging.

 # In the production environment, all the message should be valid, but in DEV

 # If need to pull the latest, by keys. un-comment below

 #   w = Window.partitionBy("environment", "source", "type", "requestHeaders").orderBy(desc("timeStamp"))

  

 # Set the dataframe to view name

 microBatchOutputDF.select(col("key").cast("string").alias("EHKey"), from_json(col("value").cast("string"), structSchemaRawDLDisputeAPI).alias("Value"), col("timeStamp").alias("EHTimestamp")) \

 .selectExpr("EHKey", "Value.*", "EHTimestamp") \

 .where("NOT(transactionRefNumber IS NULL OR applicationId IS NULL \

 OR environment IS NULL OR eventTime IS NULL OR eventType IS NULL OR serviceId IS NULL \

 OR timeStamp IS NULL)") \

 .createOrReplaceTempView("vwtDisputeRawOriginal")

 microBatchTimestamp = udf_dynamic_timestamp()

# Use the view name to apply MERGE

# NOTE: You have to use the SparkSession that has been used to define the `updates` dataframe 

  

 microBatchOutputDF._jdf.sparkSession().sql("""

 WITH PrepData AS (

 SELECT

 transactionRefNumber AS TransactionRefNumber,

 applicationId AS ApplicationID,

 disputeRequest AS DisputeRequest,

 disputeResponse AS DisputeResponse,

 environment AS Environment,

 eventId AS EventID,

 eventStatus AS EventStatus,

 eventTime AS EventTime,

 eventType AS EventType,

 eventVersion AS EventVersion,

 serviceId AS ServiceID,

 TRY_CAST(timeStamp AS TIMESTAMP) AS AnalyticsDisputeTimestamp,

 transactionConfirmationNumber AS TransactionConfirmationNumber,

 errorResponse AS ErrorResponse

 FROM vwtDisputeRawOriginal

 GROUP BY

 TransactionRefNumber,

 ApplicationID,

 DisputeRequest,

 DisputeResponse,

 Environment,

 EventID,

 EventStatus,

 EventTime,

 EventType,

 EventVersion,

 ServiceID,

 AnalyticsDisputeTimestamp,

 TransactionConfirmationNumber,

 ErrorResponse

 )

 MERGE INTO staging.LiqDispute target USING PrepData source

 ON target.TransactionRefNumber = source.TransactionRefNumber

 AND target.ApplicationID = source.ApplicationID

 AND target.Environment = source.Environment

 AND target.EventTime = source.EventTime

 AND target.EventType = source.EventType

 AND target.ServiceID = source.ServiceID

 AND target.AnalyticsDisputeTimestamp = source.AnalyticsDisputeTimestamp

 WHEN MATCHED

 AND !(target.DisputeRequest <=> source.DisputeRequest AND

 target.DisputeResponse <=> source.DisputeResponse AND

 target.EventID <=> source.EventID AND

 target.EventStatus <=> source.EventStatus AND

 target.EventVersion <=> source.EventVersion AND

 target.TransactionConfirmationNumber <=> source.TransactionConfirmationNumber AND

 target.ErrorResponse <=> source.ErrorResponse)

 AND (target.DeletedFlag = true)

 THEN UPDATE

 SET target.TransactionRefNumber = source.TransactionRefNumber,

 target.ApplicationID = source.ApplicationID,

 target.DisputeRequest = source.DisputeRequest,

 target.DisputeResponse = source.DisputeResponse,

 target.Environment = source.Environment,

 target.EventID = source.EventID,

 target.EventStatus = source.EventStatus,

 target.EventTime = source.EventTime,

 target.EventType = source.EventType,

 target.EventVersion = source.EventVersion,

 target.ServiceID = source.ServiceID,

 target.AnalyticsDisputeTimestamp = source.AnalyticsDisputeTimestamp,

 target.TransactionConfirmationNumber = source.TransactionConfirmationNumber,

 target.ErrorResponse = source.ErrorResponse,

 target.DeletedFlag = false,

 target.LastModified = CAST('{0}' AS timestamp)

 WHEN NOT MATCHED

 THEN INSERT (TransactionRefNumber,

 ApplicationID,

 DisputeRequest,

 DisputeResponse,

 Environment,

 EventID,

 EventStatus,

 EventTime,

 EventType,

 EventVersion,

 ServiceID,

 AnalyticsDisputeTimestamp,

 TransactionConfirmationNumber,

 ErrorResponse,

 DeletedFlag,

 LastModified

 )VALUES(source.TransactionRefNumber,

 source.ApplicationID,

 source.DisputeRequest,

 source.DisputeResponse,

 source.Environment,

 source.EventID,

 source.EventStatus,

 source.EventTime,

 source.EventType,

 source.EventVersion,

 source.ServiceID,

 source.AnalyticsDisputeTimestamp,

 source.TransactionConfirmationNumber,

 source.ErrorResponse,

 false,

 CAST('{0}' AS timestamp))""".format(microBatchTimestamp))

 microBatchOutputDF.unpersist()

 query = """INSERT INTO utility.ProcessLog

 SELECT

 'Dispute',

 'Dispute Structured Streaming',

 NULL,

 'Staging',

 '{0}',

 current_timestamp(),

 'StructuredStreamingStagingDispute',

 NULL,

 NULL,

 {1},

 {2},

 0,

 CAST('false' AS boolean),

 current_timestamp()""".format(starttimestamp.collect()[0][0], microBatchOutputDF.count(), microBatchOutputDF.count())

 spark.sql(query)

  

# COMMAND ----------

  

from pyspark.sql.functions import from_json

  

# use staging for this project (fin means financial and liquidation and dc45 is defined non-financial)

#"/mnt/stagingfin/db/DisputeRequest/_checkpoint" -> "/mnt/staging/db/DisputeRequest/_checkpoint"

CHECKPOINT_DIR = "/mnt/staging/db/liqdispute/_checkpoint"

TOPIC = "evh-liquidation-dispute"

BOOTSTRAP_SERVERS = "evhns-scmbpam-dev-006.servicebus.windows.net:9093"

ConnectionKey = dbutils.secrets.get(scope = "dbss-bpa-monitoring-dev-01", key = "evh-liquidation-dispute-conn-string-primary")

EH_SASL = 'kafkashaded.org.apache.kafka.common.security.plain.PlainLoginModule required username="$ConnectionString" password="' + ConnectionKey + '";'

  

sdf = (spark.readStream

 .format("kafka")

 .option("subscribe", TOPIC)

 .option("kafka.bootstrap.servers", BOOTSTRAP_SERVERS)

 .option("kafka.sasl.mechanism", "PLAIN")

 .option("kafka.security.protocol", "SASL_SSL")

 .option("kafka.sasl.jaas.config", EH_SASL)

 .option("kafka.request.timeout.ms", "60000")

 .option("kafka.session.timeout.ms", "60000")

#          .option("kafka.group.id", "evhcg-dbw-bpamonitoring")

 #.option("failOnDataLoss", "false")

 #.option("startingOffsets", "earliest")

 .load())

  

# display(sdf.select( \

#   col("key").cast("string").alias("EHKey"),

#   from_json(col("value").cast("string"), structSchemaRawDLDisputeAPI).alias("Value"),

#   col("timestamp").alias("EHTimestamp")).selectExpr("EHKey", "Value.*", "EHTimestamp"))

  

sq = (sdf.writeStream

 .format("delta")

 .foreachBatch(upsertToDelta)

 .outputMode("append")

#         .trigger(processingTime='1 minute')

 .trigger(once=True)

 .option("checkpointLocation", CHECKPOINT_DIR)

 .start())

  

# COMMAND ----------

  

#sq.isActive

  

# COMMAND ----------

  

#sq.explain()

  

# COMMAND ----------

  

#sq.recentProgress

  

# COMMAND ----------

  

#sq.status

  

# COMMAND ----------

  

#sq.stop()

  

# COMMAND ----------

  

# %sql

# select count(*) from staging.DLDisputeAPI

  

# COMMAND ----------

  

# %sql

# select * from staging.DLDisputeAPI

# order by LastModified desc