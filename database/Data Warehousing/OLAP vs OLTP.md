OLTP - payload data
OLAP - transaction reconciliation tables
What are the differences between <font color = 'orange'>data warehousing</font> and <font color = 'yellow'>data mining</font>?  
#OLTP VS #OLAP  
-   **Online-transactional processing(OLTP):** these are typically high-concurrency, low-latency, simple queries that read or update a few records at a time: Like Bank account Transactions
-   **Online Analytical Processing (OLAP):** these workloads are like periodic reporting, are typically complex queries (involving aggregates and joins) that require high-throughput scans over many records.

![[Pasted image 20220312163252.png]]

Sr.No.|Data Warehouse (OLAP)|Operational Database(OLTP)
:--:|:--|:--
1 | It involves historical processing of information. | It involves day-to-day processing.
2|OLAP systems are used by knowledge workers such as executives, managers, and analysts.|OLTP systems are used by clerks, DBAs, or database professionals.
3|It is used to analyze the business.|It is used to run the business.
4|It focuses on Information out.|It focuses on Data in.
5|It is based on Star Schema, Snowflake Schema, and Fact Constellation Schema.|It is based on Entity Relationship Model.
6|It focuses on Information out.|It is application oriented.
7|It contains historical data.|It contains current data.
8|It provides summarized and consolidated data.|It provides primitive and highly detailed data.
9|It provides summarized and multidimensional view of data.|It provides detailed and flat relational view of data.
10|The number of users is in hundreds.|The number of users is in thousands.
11|The number of records accessed is in millions.|The number of records accessed is in tens.
12|The database size is from 100GB to 100 TB.|The database size is from 100 MB to 100 GB.
13|These are highly flexible.|It provides high performance.


Sr.No.|Data Warehouse (OLAP)|Operational Database (OLTP)
:--:|:--|:--
1|Involves historical processing of information.|Involves day-to-day processing.
2|OLAP systems are used by knowledge workers such as executives, managers and analysts.|OLTP systems are used by clerks, DBAs, or database professionals.
3|Useful in analyzing the business.|Useful in running the business.
4|It focuses on Information out.|It focuses on Data in.
5|Based on Star Schema, Snowflake, Schema and Fact Constellation Schema.|Based on Entity Relationship Model.
6|Contains historical data.|Contains current data.
7|Provides summarized and consolidated data.|Provides primitive and highly detailed data.
8|Provides summarized and multidimensional view of data.|Provides detailed and flat relational view of data.
9|Number or users is in hundreds.|Number of users is in thousands.
10|Number of records accessed is in millions.|Number of records accessed is in tens.
11|Database size is from 100 GB to 1 TB|Database size is from 100 MB to 1 GB.
12|Highly flexible.|Provides high performance.