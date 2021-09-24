           
# Azure Data Factory
Azure’s cloud ETL service for scale-out serverless data integration and data transformation

### [[integration runtime]]

### Steps for Creating ETL process in Azure Data Factory 
-   Connect & Collect - Helps in moving the data from on-premises and cloud source data stores.
-   Transform - Helps in collecting the data by using compute services such as HDInsight Hadoop, Spark, etc.
-   Publish - Create a Linked Service for destination data store, Helps in loading the data into Azure Data Warehouse, Azure SQL Database, and Azure Cosmos DB, etc.
-   Monitor - Helps in supporting the pipeline monitoring via Azure Monitor, API, PowerShell, Log Analytics, and health panels on the Azure portal

* Create a Linked Service for source data store which is SQL Server Database 
* Transform - Helps in collecting the data by using compute services such as HDInsight Hadoop, Spark, etc.
* Create a Linked Service for destination data store which is Azure Data Lake Store 
* Create a dataset for Data Saving Create the pipeline and add copy activity 
* Schedule the pipeline by adding a trigger

### components
-   Pipeline: The activities logical container
-   Activity: An execution step in the Data Factory pipeline that can be used for data ingestion and transformation
-   Mapping Data Flow: A data transformation UI logic
-   Dataset: A pointer to the data used in the pipeline activities
-   Linked Service: A descriptive connection string for the data sources used in the pipeline activities
-   Trigger: Specify when the pipeline will be executed
-   Control flow: Controls the execution flow of the pipeline activities

### Azure Storage Types

Blobs  
Tables  
Files  
Queues


### schedule a pipeline
use the scheduler trigger or time window trigger to schedule a pipeline. The trigger uses a wall-clock calendar schedule, which can schedule pipelines periodically or in calendar-based recurrent patterns (for example, on Mondays at 6:00 PM and Thursdays at 9:00 PM).

### pass parameters to a pipeline run
Yes, parameters are a first-class, top-level concept in Data Factory. You can define parameters at the pipeline level and pass arguments as you execute the pipeline run on demand or by using a trigger.

### access data by using the other 80 dataset types in Data Factory
Use the Copy activity to stage data from any of the other connectors, and then execute a Data Flow activity to transform data after it’s been staged. For example, your pipeline will first copy into Blob storage, and then a Data Flow activity will use a dataset in source to transform that data



### mapping VS wrangling data flows?

**Mapping**  
It provides ways to transform data at scale without coding.  
Data flow is great.  
Helps in transforming data with both known and unknown schemas in the sinks and sources.  
**Wrangling**  
It allows us to do agile data preparation using Power Query Online mashup editor at scale via spark execution.  
Data flow is less formal.  
Helps in model based analytics scenarios.

### **Dataset VS Linked Service**

Linked Service is a description of the connection string that is used to connect to the data stores. For example, when ingesting data from a SQL Server instance, the linked service contains the name for the SQL Server instance and the credentials used to connect to that instance.

Dataset is a reference to the data store that is described by the linked service. When ingesting data from a SQL Server instance, the dataset points to the name of the table that contains the target data or the query that returns data from different tables.

### triggers
-   The Schedule trigger that is used to execute the ADF pipeline on a wall-clock schedule
-   The Tumbling window trigger that is used to execute the ADF pipeline on a periodic interval, and retains the pipeline state
-   The Event-based trigger that responds to a blob related event, such as adding or deleting a blob from an Azure storage account

### methods to execute ADF pipeline
-   Under Debug mode
-   Manual execution using Trigger now
-   Using an added scheduled, tumbling window or event trigger