`filter(array<T>, function<T, Boolean>): array<T>` 
* produces an array consisting of only the elements of the input array for which the Boolean function is true

```py
spark.sql("""
SELECT celsius,
filter(celsius, t-> t>38) as high
FROM tC
""").show()
```

results:

celsius|high
:--:|:--:
[35, 36, 32, 30, 40, 42]|[40, 42]
[31, 32, 34, 55, 56]|[55, 56]