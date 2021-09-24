To build an ETL pipeline with batch processing, you need to:

1.  <font color = 'orange'>**Create reference data**: </font>
create a dataset that defines the set of permissible values your data may contain. For example, in a country data field, specify the list of country codes allowed.
2.  <font color = 'orange'>**Extract data from different sources**: </font>
the basis for the success of subsequent ETL steps is to extract data correctly. Take data from a range of sources, such as APIs, non/relational databases, XML, JSON, CSV files, and convert it into a single format for standardized processing.
3.  <font color = 'orange'>**Validate data**: </font>
Keep data that have values in the expected ranges and reject any that do not. For example, if you only want dates from the last year, reject any values older than 12 months. Analyze rejected records, on an on-going basis, to identify issues, correct the source data, and modify the extraction process to resolve the problem in future batches.
4.  <font color = 'orange'>**[[Transform data]]**:</font> 
Remove duplicate data (cleaning), apply business rules, check data integrity (ensure that data has not been corrupted or lost), and create aggregates as necessary. For example, if you want to analyze revenue, you can summarize the dollar amount of invoices into a daily or monthly total. You need to program numerous functions to transform the data automatically. 
5.  <font color = 'orange'>**Stage data**: </font> [[staging]]
You do not typically load transformed data directly into the target data warehouse. Instead, data first enters a staging database which makes it easier to roll back if something goes wrong. At this point, you can also generate audit reports for regulatory compliance, or diagnose and repair data problems.
6.  <font color = 'orange'>**Publish to your data warehouse**: </font>
Load data to the target tables. Some data warehouses overwrite existing information whenever the ETL pipeline loads a new batch - this might happen daily, weekly, or monthly. In other cases, the ETL workflow can add data without overwriting, including a timestamp to indicate it is new. You must do this carefully to prevent the data warehouse from “exploding” due to disk space and performance limitations.