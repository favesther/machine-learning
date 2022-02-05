# Databricks notebook source

# MAGIC %run

# MAGIC "/Common Files/FunctionsShared"

  

# COMMAND ----------

  

# df = spark.read.json("/mnt/landing/DC45LiquidationSampleFile/Dispute*")

# df.schema.jsonValue()

  

# COMMAND ----------

  

import ast

from pyspark.sql.types import StructType

  

dfString = spark.read.text("/mnt/util/schemas/SchemaRawLiqDispute.dict").collect()

dictSchemaRawDispute = ast.literal_eval("".join([line.value for line in dfString]))

structSchemaRawDispute = StructType.fromJson(dictSchemaRawDispute)

dfSchemaRawDispute = spark.read.schema(structSchemaRawDispute).json("/mnt/landing/DC45LiquidationSampleFile/Dispute*")

dfSchemaRawDisputeFlat = dfSchemaRawDispute.select(flatten_struct(structSchemaRawDispute))

dfSchemaRawDispute.createOrReplaceTempView("vwtDisputeRawOriginal")

dfSchemaRawDisputeFlat.createOrReplaceTempView("vwtDisputeRaw")

  

# COMMAND ----------

  

# explode array struct type [] into json format {}

from pyspark.sql.functions import explode

dfSchemaRawDisputeExpIMEI = dfSchemaRawDispute.withColumn("DisputeIMEI", explode("disputeRequest.disputeIMEIs"))

dfSchemaRawDisputeExpIMEI.createOrReplaceTempView("vwDisputeExpIMEI")

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC SELECT * FROM vwDisputeExpIMEI

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC describe vwtDisputeRawOriginal

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC describe vwtDisputeRaw

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC SELECT * FROM vwtDisputeRaw

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC USE staging;

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC CREATE OR REPLACE TABLE staging.LiqDispute

# MAGIC USING delta

# MAGIC PARTITIONED BY (DeletedFlag, Environment, ApplicationID, EventType)

# MAGIC SELECT

# MAGIC         transactionRefNumber AS TransactionRefNumber,

# MAGIC         applicationId AS ApplicationID,

# MAGIC         disputeRequest AS DisputeRequest,

# MAGIC         disputeResponse AS DisputeResponse,

# MAGIC         environment AS Environment,

# MAGIC         eventId AS EventID,

# MAGIC         eventStatus AS EventStatus,

# MAGIC         eventTime AS EventTime,

# MAGIC         eventType AS EventType,

# MAGIC         eventVersion AS EventVersion,

# MAGIC         serviceId AS ServiceID,

# MAGIC         CAST(timeStamp AS TIMESTAMP) AS AnalyticsDisputeTimestamp,

# MAGIC         transactionConfirmationNumber AS TransactionConfirmationNumber,

# MAGIC         errorResponse AS ErrorResponse,

# MAGIC         CAST('false' AS BOOLEAN) AS DeletedFlag,

# MAGIC         current_timestamp() AS LastModified

# MAGIC FROM vwtDisputeRawOriginal

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC USE prepared;

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC CREATE OR REPLACE TABLE prepared.LiqDispute

# MAGIC USING delta

# MAGIC PARTITIONED BY (DeletedFlag, Environment, ApplicationID, EventDate, EventType)

# MAGIC AS

# MAGIC SELECT

# MAGIC         SHA2(CONCAT_WS('|',transactionRefNumber, environment, serviceId, eventId, EventTime), 256) AS LiqServiceEventDisputeKey,

# MAGIC         serviceId AS ServiceID,

# MAGIC         eventStatus AS EventStatus,

# MAGIC         environment AS Environment,

# MAGIC         CAST(timeStamp AS TIMESTAMP) AS AnalyticsDisputeTimestamp,

# MAGIC         CAST(timeStamp AS DATE) AS AnalyticsDisputeDate,

# MAGIC         transactionRefNumber AS TransactionRefNumber,

# MAGIC         transactionConfirmationNumber AS TransactionConfirmationNumber,

# MAGIC         applicationId AS ApplicationID,

# MAGIC         eventId AS EventID,

# MAGIC         eventVersion AS EventVersion,

# MAGIC         CAST(eventTime AS TIMESTAMP) AS EventTimestamp,

# MAGIC         CAST(eventTime AS DATE) AS EventDate,

# MAGIC         eventType AS EventType,

# MAGIC         `disputeRequest.disputeId` AS DisputeID,

# MAGIC         CAST(`disputeRequest.disputeClaimDate` AS TIMESTAMP) AS DisputeClaimTimestamp,

# MAGIC         CAST(`disputeRequest.disputeClaimDate` AS DATE) AS DisputeClaimDate,

# MAGIC         `disputeRequest.p_CustomerId` AS CustomerID, -- added

# MAGIC         `disputeRequest.buyerName` AS BuyerName,

# MAGIC         `disputeRequest.lotId` AS LotID,

# MAGIC         `disputeRequest.disputeCosmeticGrade` AS DisputeCosmeticGrade,

# MAGIC         `disputeRequest.disputeWarehouseId` AS DisputeWarehouseID,

# MAGIC         `disputeRequest.disputeModel` AS DisputeModel,

# MAGIC         `disputeRequest.disputeInvoiceQuantity` AS DisputeInvoiceQuantity,

# MAGIC         `disputeRequest.disputeInvoiceAmount` AS DisputeInvoiceAmount,

# MAGIC         `disputeRequest.disputePriceUnit` AS DisputePriceUnit,

# MAGIC         `disputeRequest.disputeQuantity` AS DisputeQuantity,

# MAGIC         `disputeRequest.disputeQuantityShort` AS DisputeQuantityShort,

# MAGIC         `disputeRequest.disputeComments` AS DisputeComments,

# MAGIC         `disputeRequest.disputeLink` AS DisputeLink,

# MAGIC         `disputeRequest.disputeStatusClaim` AS DisputeStatusClaim,

# MAGIC         `disputeRequest.disputeResolution` AS DisputeResolution,

# MAGIC         `disputeRequest.disputeCreditIssued` AS DisputeCreditIssued,

# MAGIC         `disputeRequest.disputeReasonCode` AS DisputeReasonCode,

# MAGIC         `disputeRequest.disputeValid` AS DisputeValid,

# MAGIC --         `disputeRequest.disputeBusinessResponse` AS DisputeBusinessResponse,

# MAGIC         `disputeResponse.status` AS DisputeResponseStatus,

# MAGIC         `disputeResponse.userMessage` AS DisputeResponseUserMessage,

# MAGIC         CAST('false' AS boolean) AS DeletedFlag,

# MAGIC         current_timestamp() AS LastModified

# MAGIC FROM vwtDisputeRaw

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC /* Appliy Nullability */

# MAGIC

# MAGIC /* Staging Table*/

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN TransactionRefNumber SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN ApplicationID SET NOT NULL;

# MAGIC -- ALTER TABLE staging.LiqDispute CHANGE COLUMN DisputeRequest SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN Environment SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN EventTime SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN EventType SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN ServiceID SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN AnalyticsDisputeTimestamp SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN DeletedFlag SET NOT NULL;

# MAGIC ALTER TABLE staging.LiqDispute CHANGE COLUMN LastModified SET NOT NULL;

  

# COMMAND ----------

  

# MAGIC %sql SELECT * FROM prepared.LiqDispute

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC /*Prepared Table */

# MAGIC

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN LiqServiceEventDisputeKey SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN ServiceID SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN Environment SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN TransactionRefNumber SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN ApplicationID SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN EventType SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN EventTimestamp SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN DeletedFlag SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN LastModified SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDispute CHANGE COLUMN AnalyticsDisputeTimestamp SET NOT NULL;

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC TRUNCATE TABLE staging.LiqDispute;

# MAGIC TRUNCATE TABLE prepared.LiqDispute;

  

# COMMAND ----------

  

# MAGIC %md ###Create IMEI Table

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC CREATE OR REPLACE TABLE prepared.LiqDisputeIMEI

# MAGIC USING delta

# MAGIC PARTITIONED BY (DeletedFlag, Environment, ApplicationID, EventDate, EventType)

# MAGIC AS

# MAGIC SELECT

# MAGIC         SHA2(CONCAT_WS('|', transactionRefNumber,environment, serviceId, eventId, eventTime), 256) AS LiqDisputeIMEIKey,

# MAGIC         transactionRefNumber AS TransactionRefNumber,

# MAGIC         applicationId AS ApplicationID,

# MAGIC         serviceId AS ServiceID,

# MAGIC         environment AS Environment,

# MAGIC         eventId AS EventID,

# MAGIC         eventType AS EventType,

# MAGIC         CAST (eventTime AS TIMESTAMP) AS EventTimestamp,

# MAGIC         CAST (eventTime AS DATE) AS EventDate,

# MAGIC         DisputeIMEI AS IMEI,

# MAGIC         CAST('false' AS BOOLEAN) AS DeletedFlag,

# MAGIC         current_timestamp() AS LastModified

# MAGIC FROM vwDisputeExpIMEI

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN LiqDisputeIMEIKey SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN TransactionRefNumber SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN ApplicationID SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN ServiceID SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN Environment SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN EventID SET NOT NULL;

# MAGIC -- ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN EventType SET NOT NULL;

# MAGIC -- ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN EventTimestamp SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN EventDate SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN IMEI SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN DeletedFlag SET NOT NULL;

# MAGIC ALTER TABLE prepared.LiqDisputeIMEI CHANGE COLUMN LastModified SET NOT NULL;

  

# COMMAND ----------