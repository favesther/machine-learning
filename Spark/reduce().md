`reduce(array<T>, B, function<B, T, B>, function<B, R>)`
* reduces the elements of the array to a single value by merging the elements into a buffer B using function and applying a finishing function on the final buffer:

```py
spark.sql("""
SELECT celsius,
		reduce(
			celsius,
			0,
			(t, acc) -> t + acc,
			acc -> (acc div size(celsius) * 9 div 5) +32
		)as avgFahrenheit
FROM tC
""").show()
```