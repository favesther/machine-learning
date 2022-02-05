# Databricks notebook source

import dlt

import ast

import re

from pyspark.sql.functions import col, input_file_name, split, lit, concat_ws, row_number, min, concat, udf, current_timestamp,decode

from pyspark.sql.types import *

from pyspark.sql.window import Window

  

# COMMAND ----------

  

def getHeaderFlag(inputStr):

 if (inputStr.count('!^') < 1) or (len(re.sub("[^0-9]", "", inputStr)) < 3) :

 return (1)

 else : return(0)

udf_checkNum = udf(lambda x : getHeaderFlag(x))

  

# COMMAND ----------

  

def splitNcleanseDF(sdf, headerList):

 sdf = sdf.withColumn("File",input_file_name())\

 .withColumn('File_Split', split("File", "_")[2][1:14].cast('bigint'))\

 .withColumn('File_Name_1', split("File", "_")[0])\

 .withColumn('File_Name_2', split("File", "_")[1])\

 .withColumn('File_Name_3', split("File", "_")[3])\

 .withColumn('File_Name_4', split("File", "_")[4])

 #  Need to cleanse the data frame since the file has the 3 rows of the header section.

 sdf = sdf.withColumn("Flag", udf_checkNum(col('value')))

 sdf = sdf.filter(col("Flag") == 0) 

  

 # split columns

 split_col = split(sdf.value, '\\!\\^')

 for i, name in enumerate(headerList) :

 sdf = sdf.withColumn(name, split_col.getItem(i))

  

 # drop unnecessary columns

 drop_list = ['value','Flag']

 sdf = sdf.drop(*drop_list)

  

 # drop null lines

 sdf = sdf.na.drop("all")

  

 expr = [col(col_name).alias(col_name.replace(' ','')) for col_name in sdf.columns]

 sdf = sdf.select(*expr)

  

 col_list = sdf.columns

 col_list.remove('File')

 col_list.remove('File_Split')

 # Filter out already existing record - since the file is acculating.

 sdf = sdf.groupby(*col_list).min("File_Split").withColumnRenamed('min(File_Split)','min')

 sdf = sdf.withColumn('File', concat(col('File_Name_1'),lit('_'), col('File_Name_2'),lit('_'), col('min'), lit('_'),col('File_Name_3'), lit('_'),col('File_Name_4')))\

 .drop('File_Name_1','File_Name_2','File_Name_3','File_Name_4', 'min')

  

 sdf = sdf.withColumn('DeletedFlag', lit(False).cast(BooleanType()))\

 .withColumn('LastModified', current_timestamp())

 return(sdf)

  
  

# COMMAND ----------

  

def load_data(dataName, structSchemaRaw, headerList, tableName, ingestDataPath):

 # define

 @dlt.table(

 name = tableName,

 comment = "Stream Read {} File and Create Staging Table".format(dataName),

 path = "/mnt/staging/db/{}".format(tableName)

 )

 # Need discussion

#   @dlt.expect("valid_date", "Date IS NOT NULL AND TRY_CAST(Date AS DATE) IS NOT NULL")

#   @dlt.expect("valid_materialnumber", "MaterialNumber IS NOT NULL")

#   @dlt.expect("valid_plant", "Plant IS NOT NULL")

 def staging_live():

 sdf = spark.readStream.format("cloudFiles")\

 .option("cloudFiles.format", "text")\

 .option("cloudFiles.maxFileAge", "30 days")\

 .load(ingestDataPath)

 #  Need to cleanse the data frame since the file has the 3 rows of the header section.

 sdf = splitNcleanseDF(sdf, headerList)

  

 return (sdf)

  

# COMMAND ----------

  

# Required: Schema file named with this format. - /mnt/util/schemas/SchemaRaw{"schemaName"}.dict

# Add here dataName and tableName pair - (dataName, schemaName, tableName)

dataNameList = [("DELIVERYORDERCREATE", "LiqSapDeliveryOrderCreate", "liqsapdeliveryordercreatelive"),\

 ("SALESORDER", "LiqSapSalesOrder", "liqsapsalesorderlive"),\

 ("PURCHASEORDER", "LiqSapPurchaseOrder", "liqsappurchaseorderlive")]

  

# For multiple streaming pipelines

for dataName, schemaName, tableName in dataNameList :

 dfString = spark.read.text("/mnt/util/schemas/SchemaRaw{}.dict".format(schemaName)).collect()

 dictSchemaRaw = ast.literal_eval("".join([line.value for line in dfString]))

 headerList = [line['name'] for line in dictSchemaRaw['fields']]

 structSchemaRaw = StructType.fromJson(dictSchemaRaw)

 ingestDataPath = "/mnt/landing/SAP/{}/".format(dataName)

 load_data(dataName, structSchemaRaw, headerList, tableName, ingestDataPath)

  

# COMMAND ----------

  

# df = spark.read.format("csv")\

#                .option('header', 'true')\

#                .load(ingestDataPath)

# df = df.withColumnRenamed('_c3','BlankColumn')\

#        .withColumnRenamed('Sales Doc.', 'SalesDoc')\

#        .withColumnRenamed('Tr. Type', 'TrType')\

#        .withColumnRenamed(' IDoc no.', 'IDocNo')

# str_dict = str(df.schema.jsonValue())

# dbutils.fs.put("/mnt/util/schemas/SchemaRawLiqSapDeliveryOrderCreate.dict", str_dict, True)

  

# COMMAND ----------