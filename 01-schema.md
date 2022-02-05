# Databricks notebook source

# MAGIC %run

# MAGIC "/Common Files/FunctionsShared"

  

# COMMAND ----------

  

import json

  

# COMMAND ----------

  

str_schema = """{

 "serviceId": "ShipmentConfirmation",

 "environment": "qlab03",

 "timeStamp": "2022-01-19T18:02:10.340Z",

 "transactionRefNumber": "20211123ordq3815",

 "imei": "352737105765813",

 "applicationId": "appid",

 "eventStatus": null,

 "eventId": null,

 "eventVersion": "B3A4431ACFEC5424",

 "eventTime": "",

 "eventType": null,

 "shipmentConfirmationInfo": {

 "shipmentConfDate": "2020-05-07",

 "transactionRefNo": "20211123ordq3815",

 "noOfCartons": null,

 "doNumber": "0841747358",

 "shipmentType": "LQD",

 "shipmentIndicator": null,

 "carrierName": "UPSG",

 "carrierAppointmentId": null,

 "carrierAppointmentDate": "2020-01-16T01:24:35.710Z",

 "carrierTruckNumber": "TRL0236223",

 "carrierPickupDate": "2020-01-16T01:24:35.710Z",

 "carrierBol": null,

 "shipmentDate": "2020-05-07",

 "shipmentTime": "15:35:23",

 "shipmentFrom": "DC45",

 "shipFromVendorId": "DC45",

 "shipToId": "DC36",

 "shipToName": "SAMSUNG",

 "shipToStreet": null,

 "shipToCity": "NY",

 "shipToPostalCode": null,

 "shipToCountry": "US",

 "orderType": "ZLQD-ZL1",

 "orderNo": "4500514963",

 "shipComplete": "Yes",

 "shipmentItems": [

 {

 "deliveryItemNo": 10,

 "orderItemNo": 1,

 "orderSkuId": "190198047717",

 "skuIdEntered": null,

 "serialNumber": "352737105765813",

 "simSerialNumber": null,

 "quantity": 1,

 "model": null,

 "make": null,

 "rmaNumber": null,

 "cartonId": "S000000FDRE7",

 "shipmentTrackingNumber": "SID0134126",

 "programType": "JUMP",

 "replacedSerialNumber": null,

 "uccCode": null,

 "palletId": "46137311",

 "movementType": "541",

 "secondaryIMEI": "Test7654"

 }

 ],

 "misshipIndicator": null,

 "skuDescription": null,

 "externalRMANumber": null,

 "serialNumberList": [

 {

 "serialNumType": "IMEI",

 "serialNumber": "BBCD13323498"

 }

 ],

 "lotId": "76125980"

 },

 "shipmentConfirmationInfoResponse": {

 "transconfirmNumber": null,

 "interfaceName": null,

 "sessionId": null,

 "statusText": null,

 "transactionRefNo": null

 },

 "errors": [

 {

 "code": "OSC-109",

 "userMessage": "Invalid serialnumber for Shipment. Inventory status should be Received.",

 "systemMessage": "Business validations failed - Shipment Confirmation.",

 "detailLink": null

 }

 ]

}"""

  

# COMMAND ----------

  

# MAGIC %md Save Schema & Sample File

  

# COMMAND ----------

  

df = spark.read.json(sc.parallelize([str_schema]))

  

# COMMAND ----------

  

str_dict = str(df.schema.jsonValue())

dbutils.fs.put("/mnt/util/schemas/SchemaRawLiqTransferOrderValidation.dict", str_dict, True)

  

# COMMAND ----------

  

 dbutils.fs.ls("/mnt/util/schemas/")

  

# COMMAND ----------

  

dbutils.fs.ls("/mnt/landing/DC45LiquidationSampleFile/")

  

# COMMAND ----------