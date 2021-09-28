This indicates when to trigger the discovery and processing of newly available streaming data.
# Default

When the trigger is not explicitly specified, then by default, the streaming query executes data in micro-batches where the next micro-batch is triggered as soon as the previous micro-batch has completed.

# Processing time with trigger interval

You can explicitly specify the `ProcessingTime` trigger with an interval, and the query will trigger micro-batches at that fixed interval.

# Once

In this mode, the streaming query will execute exactly one micro-batch—it processes all the new data available in a single batch and then stops itself. This is useful when you want to control the triggering and processing from an external scheduler that will restart the query using any custom schedule (e.g., to control cost by only executing a query [once per day](https://oreil.ly/Y7EZy)).

# Continuous

This is an experimental mode (as of Spark 3.0) where the streaming query will process data continuously instead of in micro-batches. While only a small subset of DataFrame operations allow this mode to be used, it can provide much lower latency (as low as milliseconds) than the micro-batch trigger modes. Refer to the latest [Structured Streaming Programming Guide](https://oreil.ly/7cERT) for the most up-to-date information.