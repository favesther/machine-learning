### difference
* **Star Schema**: Well in star schema you just enter your desired facts and all the primary keys of your dimensional tables in Fact table. And fact tables primary is the union of its all dimension table key. In star schema dimensional tables are usually not in BCNF form. 
* **Snow Flake**: Its almost like starschema but in this our dimension tables are in **3rd NF,** so **more dimensions tables**. And these dimension tables are linked by primary, foreign key relation.

![[Pasted image 20220312163335.png]]
  
![[Pasted image 20220312163345.png]]

Star Schema | Snowflake Schema
:--|:--
Hierarchies for the dimensions are stored in the dimensional table.|Hierarchies are divided into separate tables.
It contains a fact table surrounded by dimension tables.|One fact table surrounded by dimension table which is in turn surrounded by dimension table
In a star schema, only a single join creates the relationship between the fact table and any dimension tables.|A snowflake schema requires many joins to fetch the data.
It has a simple database design|It has a complex database design
Denormalized data structure and query also run faster.|Normalized data Structure.
High level of data redundancy|Very low-level data redundancy
Offers higher-performing queries using Star Join Query Optimization. Tables may be connected with multiple dimensions. |The Snow Flake Schema is represented by a centralized fact table which unlikely connected with multiple dimensions.