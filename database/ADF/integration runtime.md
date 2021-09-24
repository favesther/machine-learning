Integration Runtime is a secure compute infrastructure that is used by Data Factory to provide the data integration capabilities across the different network environments and make sure that these activities will be executed in the closest possible region to the data store.

### 3 Types: 
1. <font color='orange'>Azure Integration Run Time:</font>
used for copying data from or to data stores accessed publicly via the internet

2. <font color='orange'>Self Hosted Integration Run Time: </font>
used for copying data from or to an on-premises data store or networks with access control
3. <font color='orange'>Azure SSIS Integration Run Time: </font>
used to run SSIS packages in the Data Factory
A fully managed cluster of virtual machines hosted in Azure and dedicated to run SSIS packages in the Data Factory. The SSIS IR nodes can be scaled up, by configuring the node size, or scaled out by configuring the number of nodes in the VMs cluster.


### the limit on the number of integration runtimes
There is no hard limit on the number of integration runtime instances you can have in a data factory. There is, however, **a limit on the number of VM cores** that the integration runtime can use per subscription for SSIS package execution.