### difference between Azure Data Lake and Azure Data Warehouse? 
Data Warehouse is a traditional way of storing data which is still used widely. Data Lake is complementary to Data Warehouse i.e if you have your data at a data lake that can be stored in data warehouse as well but there are certain rules that need to be followed. 

DATA LAKE|DATA WAREHOUSE 
:--|:--
Complementary to data warehouse |Maybe sourced to the data lake 
Data is Detailed data or Raw data. It can be in any particular form.you just need to take the data and dump it into your data lake |Data is filtered, summarised,refined 
Schema on read (not structured, you can define your schema in n number of ways) | Schema on write(data is written in Structured form or in a particular schema) 
One language to process data of any format(USQL) | It uses SQL