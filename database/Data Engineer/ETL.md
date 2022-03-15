### ETL process:
Database -> structured streaming script (EVH to staging) -> merge script(ingestion, staging to prepared)

### Problems:
* Failures:
	* retry count, (structured streaming, set timeout limit)
* monitoring:
	* success/failure: push alert to mailbox/slack
		* sql alert - error/no activity (record count == 0)
		* job alert
* dependencies:
	* data dependencies: e.g. upstream data is missing (FedEx missing/DL missing)
	* execution dependencies within a job: e.g. main table (accumulative daily records that shows history)->  final status table (iteratively updated final status of all the transactions )
* Scalability:
	* there is no centralized scheduler between different cron machines (use spreadsheet to track the schedule of all the jobs and manually adjust the schedule to optimize cluster performance) 
* Deployment:
	* deploy new changes constantly (CICD)
* Process historic data:
	* rerun historical data (add fields missing in the designed schema, repopulate staging table by pulling data from the event hub)
