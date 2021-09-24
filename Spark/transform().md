`transform(array<T>, function<T, U>): array<U>`
* produces an array by applying a function to each element of the input array (similar to a `map()` function):

## e.g. 
* add a new column of arrays to an existing dataframe(tempView)

```py
spark.sql("""
SELECT celsius,
transform(celsius, t -> ((t * 9) div 5) + 32) as fahrenheit
FROM tC
""").show()
```

Results:

celsius| fahrenheit
:--:|:--:
 [35, 36, 32, 30, ...]|[95, 96, 89, 86, ...]
 [31, 32, 34, 55, 56]|[87, 89, 93, 131,...]