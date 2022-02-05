# Databricks notebook source

starttimestamp = spark.sql('SELECT current_timestamp()')

  

# COMMAND ----------

  

# MAGIC %run

# MAGIC "/Common Files/FunctionsShared"

  

# COMMAND ----------

  

#//. Removing Widgets .//

#//  Environment ex.  '"plab01","development" or '*'

dbutils.widgets.removeAll();

dbutils.widgets.dropdown("FullLoad", "False", ["True", "False"])

#dbutils.widgets.text("Enviroment", "*")

  

fullload_bool = str_to_bool(get_argument_value_or_default("FullLoad", False))

dtLastProcessDate = spark.sql("select PrepareLastProcessDate from utility.ProcessDataConfiguration where Capability = 'Dispute'").collect()[0][0]

  

if fullload_bool:

 dtLastProcessDate = '2010-01-01 00:20:00.000000'

  

stParameters = "FullLoad: " + dbutils.widgets.get("FullLoad") + " PrepareLastProcessDate: {}".format(dtLastProcessDate)

  

print(stParameters)

  

notebookName = dbutils.notebook.entry_point.getDbutils().notebook().getContext().notebookPath().get().split('/')[-1]

print(notebookName)

  

# COMMAND ----------

  

# MAGIC %md

# MAGIC ###Flattern Dispute API JSON data

  

# COMMAND ----------

  

query = """

 SELECT

 SHA2(CONCAT_WS('|',TransactionRefNumber,Environment, ServiceID, EventID, EventTime) , 256) AS LiqServiceEventDisputeKey,

 ServiceID,

 EventStatus,

 Environment,

 TRY_CAST(AnalyticsDisputeTimestamp AS TIMESTAMP) AS AnalyticsDisputeTimestamp,

 TRY_CAST(AnalyticsDisputeTimestamp AS DATE) AS AnalyticsDisputeDate,

 TransactionRefNumber,

 TransactionConfirmationNumber,

 ApplicationID,

 EventID,

 EventVersion,

 TRY_CAST(EventTime AS TIMESTAMP) AS EventTimestamp,

 TRY_CAST(EventTime AS DATE) AS EventDate,

 EventType,

 DisputeRequest.disputeId AS DisputeID,

 TRY_CAST(DisputeRequest.disputeClaimDate AS TIMESTAMP) AS DisputeClaimTimestamp,

 TRY_CAST(DisputeRequest.disputeClaimDate AS DATE) AS  DisputeClaimDate,

 DisputeRequest.p_CustomerId AS CustomerID,

 DisputeRequest.buyerName AS BuyerName,

 DisputeRequest.lotId AS LotID,

 DisputeRequest.disputeCosmeticGrade DisputeCosmeticGrade,

 DisputeRequest.disputeWarehouseId DisputeWarehouseID,

 DisputeRequest.disputeModel DisputeModel,

 DisputeRequest.disputeInvoiceQuantity DisputeInvoiceQuantity,

 DisputeRequest.disputeInvoiceAmount DisputeInvoiceAmount,

 DisputeRequest.disputePriceUnit DisputePriceUnit,

 DisputeRequest.disputeQuantity AS DisputeQuantity,

 DisputeRequest.disputeQuantityShort DisputeQuantityShort,

 DisputeRequest.disputeComments AS DisputeComments,

 DisputeRequest.disputeLink AS DisputeLink,

 DisputeRequest.disputeStatusClaim DisputeStatusClaim,

 DisputeRequest.disputeResolution AS DisputeResolution,

 DisputeRequest.disputeCreditIssued AS DisputeCreditIssued,

 DisputeRequest.disputeReasonCode AS DisputeReasonCode,

 ex_imei AS IMEI,

 DisputeRequest.disputeValid AS DisputeValid,

 -- DisputeResponse.DisputeBusinessResponse

 DisputeResponse.status AS DisputeResponseStatus,

 DisputeResponse.userMessage AS DisputeResponseUserMessage,

 ex_error.code AS Code,

 ex_error.userMessage AS UserMessage,

 ex_error.systemMessage AS SystemMessage,

 ex_error.detailLink AS DetailLink,

 CONCAT(

 COALESCE(ex_error.code, ''), '-',

 COALESCE(ex_error.userMessage, ''), '-',

 COALESCE(ex_error.systemMessage, ''), '-',

 COALESCE(ex_error.detailLink, ''), ''

 ) AS LiqErrorResponseKey,

 DeletedFlag,

 LastModified,

 CONCAT(

 COALESCE(Environment, ''), '-',

 COALESCE(ApplicationID, ''), '-',

 COALESCE(ServiceId, ''),'-',

 COALESCE(EventType, ''), '-',

 COALESCE(TransactionRefNumber, ''), '-',

 COALESCE(CAST (EventTime AS TIMESTAMP), ''),''

 ) AS LiqDisputeKey,

 CASE WHEN COALESCE(try_cast(AnalyticsDisputeTimestamp AS TIMESTAMP), '') = '' OR

 COALESCE(try_cast(EventTime AS TIMESTAMP), '') = ''

 THEN 'X'

 ELSE NULL

 END AS TimeFormatError

 FROM staging.LiqDispute

 LATERAL VIEW OUTER explode(disputeRequest.disputeIMEIs) exploded_imei as ex_imei

 LATERAL VIEW OUTER explode(errorResponse) exploded_error as ex_error

 WHERE LastModified > '{0}'

 AND DeletedFlag = CAST('false' AS boolean)""".format(dtLastProcessDate)

  

DisputeAPIOriginal = spark.sql(query)

DisputeAPIOriginal.createOrReplaceTempView("vwtDisputeAPIOriginal")

  

# COMMAND ----------

  

query = """

 SELECT *,

 row_number() OVER (PARTITION BY LiqDisputeKey ORDER BY CAST(AnalyticsDisputeTimestamp AS timestamp) DESC) AS Rank,

 row_number() OVER (PARTITION BY LiqDisputeKey, IMEI ORDER BY CAST(AnalyticsDisputeTimestamp AS timestamp) DESC) AS IMEIRank,

 row_number() OVER (PARTITION BY LiqDisputeKey, LiqErrorResponseKey ORDER BY CAST(AnalyticsDisputeTimestamp AS timestamp) DESC) AS ErrorRank

 FROM vwtDisputeAPIOriginal

 WHERE TimeFormatError IS NULL

 ORDER BY Environment, ApplicationID, ServiceID, EventType, TransactionRefNumber, EventTimestamp"""

  

DisputeAPICleaned = spark.sql(query)

DisputeAPICleaned.persist()

DisputeAPICleaned.createOrReplaceTempView("vwtDisputeAPICleaned")

  

# COMMAND ----------

  

totalcount = spark.sql("select count(*) from vwtDisputeAPIOriginal").collect()[0][0]

  

#### Time Errors

  

timestamperrorcount = spark.sql("select count(*) from vwtDisputeAPIOriginal where TimeFormatError IS NOT NULL").collect()[0][0]

  

processcount = spark.sql("""select count(*) from vwtDisputeAPICleaned where

 Rank = 1""").collect()[0][0]

### Question

  

errorcount = timestamperrorcount

  

print(totalcount)

print(processcount)

print(errorcount)

  

# COMMAND ----------

  

# MAGIC %md

# MAGIC ###Merge Dispute API Prepared Tables

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC WITH PrepData AS (

# MAGIC       SELECT *

# MAGIC         FROM vwtDisputeAPICleaned

# MAGIC           WHERE Rank = 1

# MAGIC                  )

# MAGIC MERGE INTO prepared.liqdispute target USING PrepData source

# MAGIC     ON target.TransactionRefNumber = source.TransactionRefNumber AND

# MAGIC        target.ApplicationID = source.ApplicationID AND

# MAGIC        target.Environment = source.Environment AND

# MAGIC        target.AnalyticsDisputeTimestamp = source.AnalyticsDisputeTimestamp AND

# MAGIC        target.EventTimestamp = source.EventTimestamp AND

# MAGIC        target.EventType = source.EventType AND

# MAGIC        target.ServiceID = source.ServiceID

# MAGIC WHEN MATCHED

# MAGIC      AND !(target.LiqServiceEventDisputeKey <=> source.LiqServiceEventDisputeKey AND

# MAGIC            target.EventStatus <=> source.EventStatus AND

# MAGIC            target.AnalyticsDisputeDate <=> source.AnalyticsDisputeDate AND

# MAGIC            target.TransactionConfirmationNumber <=> source.TransactionConfirmationNumber AND

# MAGIC            target.EventID <=> source.EventID AND

# MAGIC            target.EventVersion <=> source.EventVersion AND

# MAGIC            target.EventDate <=> source.EventDate AND

# MAGIC            target.DisputeID <=> source.DisputeID AND

# MAGIC            target.DisputeClaimTimestamp <=> source.DisputeClaimTimestamp AND

# MAGIC            target.DisputeClaimDate <=> source.DisputeClaimDate AND

# MAGIC --            target.CustomerID <=> source.CustomerID AND

# MAGIC            target.BuyerName <=> source.BuyerName AND

# MAGIC            target.LotID <=> source.LotID AND

# MAGIC            target.DisputeCosmeticGrade <=> source.DisputeCosmeticGrade AND

# MAGIC            target.DisputeWarehouseID <=> source.DisputeWarehouseID AND

# MAGIC            target.DisputeModel <=> source.DisputeModel AND

# MAGIC            target.DisputeInvoiceQuantity <=> source.DisputeInvoiceQuantity AND

# MAGIC            target.DisputeInvoiceAmount <=> source.DisputeInvoiceAmount AND

# MAGIC            target.DisputePriceUnit <=> source.DisputePriceUnit AND

# MAGIC            target.DisputeQuantity <=> source.DisputeQuantity AND

# MAGIC            target.DisputeQuantityShort <=> source.DisputeQuantityShort AND

# MAGIC            target.DisputeComments <=> source.DisputeComments AND

# MAGIC            target.DisputeLink <=> source.DisputeLink AND

# MAGIC            target.DisputeStatusClaim <=> source.DisputeStatusClaim AND

# MAGIC            target.DisputeResolution <=> source.DisputeResolution AND

# MAGIC            target.DisputeCreditIssued <=> source.DisputeCreditIssued AND

# MAGIC            target.DisputeReasonCode <=> source.DisputeReasonCode AND

# MAGIC            target.DisputeValid <=> source.DisputeValid AND

# MAGIC --            target.DisputeBusinessResponse <=> source.DisputeBusinessResponse AND

# MAGIC            target.DisputeResponseStatus <=> source.DisputeResponseStatus AND

# MAGIC            target.DisputeResponseUserMessage <=> source.DisputeResponseUserMessage)

# MAGIC       AND (target.DeletedFlag = true)

# MAGIC THEN UPDATE

# MAGIC      SET target.LiqServiceEventDisputeKey = source.LiqServiceEventDisputeKey,

# MAGIC          target.ServiceID = source.ServiceID,

# MAGIC          target.EventStatus = source.EventStatus,

# MAGIC          target.Environment = source.Environment,

# MAGIC          target.AnalyticsDisputeTimestamp = source.AnalyticsDisputeTimestamp,

# MAGIC          target.AnalyticsDisputeDate = source.AnalyticsDisputeDate,

# MAGIC          target.TransactionRefNumber = source.TransactionRefNumber,

# MAGIC          target.TransactionConfirmationNumber = source.TransactionConfirmationNumber,

# MAGIC          target.ApplicationID = source.ApplicationID,

# MAGIC          target.EventID = source.EventID,

# MAGIC          target.EventVersion = source.EventVersion,

# MAGIC          target.EventTimestamp = source.EventTimestamp,

# MAGIC          target.EventDate = source.EventDate,

# MAGIC          target.EventType = source.EventType,

# MAGIC          target.DisputeID = source.DisputeID,

# MAGIC          target.DisputeClaimTimestamp = source.DisputeClaimTimestamp,

# MAGIC          target.DisputeClaimDate = source.DisputeClaimDate,

# MAGIC          target.CustomerID = source.CustomerID,

# MAGIC          target.BuyerName = source.BuyerName,

# MAGIC          target.LotID = source.LotID,

# MAGIC          target.DisputeCosmeticGrade = source.DisputeCosmeticGrade,

# MAGIC          target.DisputeWarehouseID = source.DisputeWarehouseID,

# MAGIC          target.DisputeModel = source.DisputeModel,

# MAGIC          target.DisputeInvoiceQuantity = source.DisputeInvoiceQuantity,

# MAGIC          target.DisputeInvoiceAmount = source.DisputeInvoiceAmount,

# MAGIC          target.DisputePriceUnit = source.DisputePriceUnit,

# MAGIC          target.DisputeQuantity = source.DisputeQuantity,

# MAGIC          target.DisputeQuantityShort = source.DisputeQuantityShort,

# MAGIC          target.DisputeComments = source.DisputeComments,

# MAGIC          target.DisputeLink = source.DisputeLink,

# MAGIC          target.DisputeStatusClaim = source.DisputeStatusClaim,

# MAGIC          target.DisputeResolution = source.DisputeResolution,

# MAGIC          target.DisputeCreditIssued = source.DisputeCreditIssued,

# MAGIC          target.DisputeReasonCode = source.DisputeReasonCode,

# MAGIC          target.DisputeValid = source.DisputeValid,

# MAGIC --          target.DisputeBusinessResponse = source.DisputeBusinessResponse,

# MAGIC          target.DisputeResponseStatus = source.DisputeResponseStatus,

# MAGIC          target.DisputeResponseUserMessage = source.DisputeResponseUserMessage,

# MAGIC          target.DeletedFlag = false,

# MAGIC          LastModified = current_timestamp()

# MAGIC WHEN NOT MATCHED

# MAGIC THEN INSERT (LiqServiceEventDisputeKey,

# MAGIC              ServiceID,

# MAGIC              EventStatus,

# MAGIC              Environment,

# MAGIC              AnalyticsDisputeTimestamp,

# MAGIC              AnalyticsDisputeDate,

# MAGIC              TransactionRefNumber,

# MAGIC              TransactionConfirmationNumber,

# MAGIC              ApplicationID,

# MAGIC              EventID,

# MAGIC              EventVersion,

# MAGIC              EventTimestamp,

# MAGIC              EventDate,

# MAGIC              EventType,

# MAGIC              DisputeID,

# MAGIC              DisputeClaimTimestamp,

# MAGIC              DisputeClaimDate,

# MAGIC              CustomerID,

# MAGIC              BuyerName,

# MAGIC              LotID,

# MAGIC              DisputeCosmeticGrade,

# MAGIC              DisputeWarehouseID,

# MAGIC              DisputeModel,

# MAGIC              DisputeInvoiceQuantity,

# MAGIC              DisputeInvoiceAmount,

# MAGIC              DisputePriceUnit,

# MAGIC              DisputeQuantity,

# MAGIC              DisputeQuantityShort,

# MAGIC              DisputeComments,

# MAGIC              DisputeLink,

# MAGIC              DisputeStatusClaim,

# MAGIC              DisputeResolution,

# MAGIC              DisputeCreditIssued,

# MAGIC              DisputeReasonCode,

# MAGIC              DisputeValid,

# MAGIC --              DisputeBusinessResponse,

# MAGIC              DisputeResponseStatus,

# MAGIC              DisputeResponseUserMessage,

# MAGIC              DeletedFlag,

# MAGIC              LastModified

# MAGIC      )VALUES(source.LiqServiceEventDisputeKey,

# MAGIC             source.ServiceID,

# MAGIC             source.EventStatus,

# MAGIC             source.Environment,

# MAGIC             source.AnalyticsDisputeTimestamp,

# MAGIC             source.AnalyticsDisputeDate,

# MAGIC             source.TransactionRefNumber,

# MAGIC             source.TransactionConfirmationNumber,

# MAGIC             source.ApplicationID,

# MAGIC             source.EventID,

# MAGIC             source.EventVersion,

# MAGIC             source.EventTimestamp,

# MAGIC             source.EventDate,

# MAGIC             source.EventType,

# MAGIC             source.DisputeID,

# MAGIC             source.DisputeClaimTimestamp,

# MAGIC             source.DisputeClaimDate,

# MAGIC             source.CustomerID,

# MAGIC             source.BuyerName,

# MAGIC             source.LotID,

# MAGIC             source.DisputeCosmeticGrade,

# MAGIC             source.DisputeWarehouseID,

# MAGIC             source.DisputeModel,

# MAGIC             source.DisputeInvoiceQuantity,

# MAGIC             source.DisputeInvoiceAmount,

# MAGIC             source.DisputePriceUnit,

# MAGIC             source.DisputeQuantity,

# MAGIC             source.DisputeQuantityShort,

# MAGIC             source.DisputeComments,

# MAGIC             source.DisputeLink,

# MAGIC             source.DisputeStatusClaim,

# MAGIC             source.DisputeResolution,

# MAGIC             source.DisputeCreditIssued,

# MAGIC             source.DisputeReasonCode,

# MAGIC             source.DisputeValid,

# MAGIC --             source.DisputeBusinessResponse,

# MAGIC             source.DisputeResponseStatus,

# MAGIC             source.DisputeResponseUserMessage,

# MAGIC             false,

# MAGIC             current_timestamp())

  

# COMMAND ----------

  

# MAGIC %md ###Merge IMEI Table

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC WITH PrepData AS (

# MAGIC        SELECT 

# MAGIC                   LiqServiceEventDisputeKey AS LiqDisputeIMEIKey,

# MAGIC                   TransactionRefNumber,

# MAGIC                   ApplicationID,

# MAGIC                   ServiceID,

# MAGIC                   Environment,

# MAGIC                   EventID,

# MAGIC                   EventType,

# MAGIC                   EventTimestamp,

# MAGIC                   EventDate,

# MAGIC                   IMEI,

# MAGIC                   CAST('false' AS BOOLEAN) AS DeletedFlag,

# MAGIC                   current_timestamp() AS LastModified

# MAGIC         FROM vwtDisputeAPICleaned

# MAGIC         WHERE IMEIRank = 1 AND IMEI IS NOT NULL

# MAGIC                  ) 

# MAGIC MERGE INTO prepared.LiqDisputeIMEI target USING PrepData source

# MAGIC     ON target.TransactionRefNumber = source.TransactionRefNumber AND

# MAGIC        target.ApplicationID = source.ApplicationID AND

# MAGIC        target.ServiceID = source.ServiceID AND

# MAGIC        target.Environment = source.Environment AND

# MAGIC        target.EventID = source.EventID AND

# MAGIC        target.EventTimestamp = source.EventTimestamp AND

# MAGIC        target.EventDate = source.EventDate AND

# MAGIC        target.IMEI <=> source.IMEI

# MAGIC WHEN MATCHED

# MAGIC      AND !(target.LiqDisputeIMEIKey <=> source.LiqDisputeIMEIKey AND

# MAGIC            target.EventType <=> source.EventType)

# MAGIC      AND (target.DeletedFlag = true)

# MAGIC THEN UPDATE

# MAGIC      SET target.LiqDisputeIMEIKey = source.LiqDisputeIMEIKey,

# MAGIC          target.TransactionRefNumber = source.TransactionRefNumber,

# MAGIC          target.ApplicationID = source.ApplicationID,

# MAGIC          target.ServiceID = source.ServiceID,

# MAGIC          target.Environment = source.Environment,

# MAGIC          target.EventID = source.EventID,

# MAGIC          target.EventType = source.EventType,

# MAGIC          target.EventTimestamp = source.EventTimestamp,

# MAGIC          target.EventDate = source.EventDate,

# MAGIC          target.IMEI = source.IMEI,

# MAGIC          target.DeletedFlag = false,

# MAGIC          LastModified = current_timestamp()

# MAGIC WHEN NOT MATCHED

# MAGIC THEN INSERT (LiqDisputeIMEIKey,

# MAGIC              TransactionRefNumber,

# MAGIC              ApplicationID,

# MAGIC              ServiceID,

# MAGIC              Environment,

# MAGIC              EventID,

# MAGIC              EventType,

# MAGIC              EventTimestamp,

# MAGIC              EventDate,

# MAGIC              IMEI,

# MAGIC              DeletedFlag,

# MAGIC              LastModified)

# MAGIC       VALUES(source.LiqDisputeIMEIKey,

# MAGIC              source.TransactionRefNumber,

# MAGIC              source.ApplicationID,

# MAGIC              source.ServiceID,

# MAGIC              source.Environment,

# MAGIC              source.EventID,

# MAGIC              source.EventType,

# MAGIC              source.EventTimestamp,

# MAGIC              source.EventDate,

# MAGIC              source.IMEI,

# MAGIC              FALSE,

# MAGIC              current_timestamp())

  

# COMMAND ----------

  

# MAGIC %md ###Merge ErrorResponse Table

  

# COMMAND ----------

  

# MAGIC %sql

# MAGIC WITH PrepData AS (

# MAGIC        SELECT 

# MAGIC                   LiqServiceEventDisputeKey as LiqServiceEventErrorKey,

# MAGIC                   'TransactionRefNumber' as ErrorPayloadType,

# MAGIC                   TransactionRefNumber as ErrorPayloadKey,

# MAGIC                   'Dispute' as ErrorOrigination,

# MAGIC                   EventTimestamp,

# MAGIC                   EventDate,

# MAGIC                   Code,

# MAGIC                   UserMessage,

# MAGIC                   SystemMessage,

# MAGIC                   DetailLink,

# MAGIC                   CAST('false' AS BOOLEAN) AS DeletedFlag,

# MAGIC                   current_timestamp() AS LastModified

# MAGIC         FROM vwtDisputeAPICleaned

# MAGIC         WHERE ErrorRank = 1 And EventTimestamp IS NOT NULL AND EventDate IS NOT NULL AND Code IS NOT NULL

# MAGIC                  ) 

# MAGIC MERGE INTO prepared.LiqServiceEventError target USING PrepData source

# MAGIC     ON target.ErrorPayloadType = source.ErrorPayloadType AND

# MAGIC        target.ErrorPayloadKey = source.ErrorPayloadKey AND

# MAGIC        target.ErrorOrigination = source.ErrorOrigination AND

# MAGIC        target.Code = source.Code AND

# MAGIC        target.EventTimestamp <=> source.EventTimestamp

# MAGIC WHEN MATCHED

# MAGIC      AND !(target.LiqServiceEventErrorKey <=> source.LiqServiceEventErrorKey AND

# MAGIC            target.UserMessage <=> source.UserMessage AND

# MAGIC            target.SystemMessage <=> source.SystemMessage AND

# MAGIC            target.DetailLink <=> source.DetailLink)

# MAGIC      AND (target.DeletedFlag = true)

# MAGIC THEN UPDATE

# MAGIC      SET target.LiqServiceEventErrorKey = source.LiqServiceEventErrorKey,

# MAGIC          target.ErrorPayloadType = source.ErrorPayloadType,

# MAGIC          target.ErrorPayloadKey = source.ErrorPayloadKey,

# MAGIC          target.ErrorOrigination = source.ErrorOrigination,

# MAGIC          target.EventTimestamp = source.EventTimestamp,

# MAGIC          target.EventDate = source.EventDate,

# MAGIC          target.Code = source.Code,

# MAGIC          target.UserMessage = source.UserMessage,

# MAGIC          target.SystemMessage = source.SystemMessage,

# MAGIC          target.DetailLink = source.DetailLink,

# MAGIC          target.DeletedFlag = false,

# MAGIC          LastModified = current_timestamp()

# MAGIC WHEN NOT MATCHED

# MAGIC THEN INSERT (LiqServiceEventErrorKey,

# MAGIC              ErrorPayloadType,

# MAGIC              ErrorPayloadKey,

# MAGIC              ErrorOrigination,

# MAGIC              EventTimestamp,

# MAGIC              EventDate,

# MAGIC              Code,

# MAGIC              UserMessage,

# MAGIC              SystemMessage,

# MAGIC              DetailLink,

# MAGIC              DeletedFlag,

# MAGIC              LastModified)

# MAGIC       VALUES(source.LiqServiceEventErrorKey,

# MAGIC              source.ErrorPayloadType,

# MAGIC              source.ErrorPayloadKey,

# MAGIC              source.ErrorOrigination,

# MAGIC              source.EventTimestamp,

# MAGIC              source.EventDate,

# MAGIC              source.Code,

# MAGIC              source.UserMessage,

# MAGIC              source.SystemMessage,

# MAGIC              source.DetailLink,

# MAGIC              FALSE,

# MAGIC              current_timestamp())

  

# COMMAND ----------

  

# MAGIC %md

# MAGIC ###Merge Error Table

  

# COMMAND ----------

  

# %sql

# INSERT INTO prepared.lkperrordescription (ErrorDescriptionId, IngestionType, ErrorDescription, DeletedFlag, LastModified)

# VALUES (41, "Dispute", "Dispute Invalid TimeStamp Received in Event, DisputeClaimDate, Analytical", false, current_timestamp());

  

# INSERT INTO prepared.lkperrordescription (ErrorDescriptionId, IngestionType, ErrorDescription, DeletedFlag, LastModified)

# VALUES (42, "Dispute", "Dispute Null Value Received in Required Field", false, current_timestamp());

  

# COMMAND ----------

  
  
  

# COMMAND ----------

  

query = """

UPDATE utility.ProcessDataConfiguration

SET PrepareLastProcessDate = '{}',

LastModified = current_timestamp()

WHERE Capability = 'Dispute'""".format(starttimestamp.collect()[0][0])

spark.sql(query)

  

# COMMAND ----------

  

query = """INSERT INTO utility.ProcessLog

 SELECT

 'Dispute',

 'Dispute Merge',

 NULL,

 'Prepared',

 '{0}',

 current_timestamp(),

 '{1}',

 '{2}',

 NULL,

 {3},

 {4},

 {5},

 CAST('false' AS boolean),

 current_timestamp()""".format(starttimestamp.collect()[0][0], notebookName, stParameters, totalcount, processcount, errorcount)

  

spark.sql(query)

  

# COMMAND ----------

  

DisputeAPICleaned.unpersist()