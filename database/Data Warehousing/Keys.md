# primary key
one or more columns to identify one row

# partition key
the first column in the composite primary key

> second column is clustering key

-   The **Partition Key** is responsible for data distribution across your nodes.
-   The **Clustering Key** is responsible for data sorting within the partition.
-   The **Primary Key** is equivalent to the **Partition Key** in a single-field-key table (i.e. **Simple**).
-   The **Composite/Compound Key** is just any multiple-column key

   

# Natural Keys
* Not query “friendly” (slow joins)
* Don’t support slowly changing dimensions(grain)
* Very important for ETL (identifying key in source system)

# surrogate key
A surrogate key (or synthetic key, pseudokey, entity identifier, factless key, or technical key) in a database is <font color ='orange'>**a unique identifier for either an entity in the modeled world or an object in the database**.</font>


* Replacement key for Natural keys used in a data warehouse
* Fast joins (due to INT datatype)
* Do support slowly changing dimensions (allows Natural Keys to repeat)
* Allow mixing of multiple source systems with overlapping data
* Not an identifying key in the source system