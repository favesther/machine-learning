   

Calculations can be done in the presentation layer, but that can be costly on performance. Adding time to report rendering can be frustrating for users, adding seconds, minutes, or even hours to an ETL process to pre-calculate data values can be more acceptable

   

Not all data sources store history, so ETL and a data warehouse/data mart can store the historical data for those sources

Example, MS Dynamics AX doesn’t store historical records for most objects unless customized to do so

Data from spreadsheets and files do not have history that can be queried



Reporting can negatively impact performance of source systems. Creation of dedicated reporting systems offloads that performance impact.

#OLTP systems are optimized for inserts and updates, not for large data reads

Alleviate stress on systems from reporting queries which run the day to day operations of a company – sales, finance, ordering, inventory