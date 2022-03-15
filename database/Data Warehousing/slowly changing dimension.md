> dimensions where attribute values vary with time

Types|Description
:--|:--
Type 0| doesn't change. **Date of Birth**
Type 1| update on iteration (no history)
Type 2| preserve unlimited history. Add start date and end date, current value where end date is null.
Type 3| limited history. current and previous. old sku and new sku
Type 4| historical data preserved in a separate table. main table only shows current value

