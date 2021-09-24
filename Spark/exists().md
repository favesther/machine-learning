`exists(array<T>, function<T, V, Boolean>): Boolean`
* returns true if the Boolean function holds for any element in the input array

```SQL
SELECT celsius,
		exists(celsius, t -> t=38) as threshold
FROM tC
```

results:

celsius|threshold
:--:|:--:
[35, 36, 32, 30, 40, 42]|true