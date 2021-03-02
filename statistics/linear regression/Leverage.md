## definition
First type of outlier is when you have explanatory variables that are extreme.
Leverage measures how unusual or extreme the
explanatory variables are for each observation.
![[Pasted image 20201116171518.png]]

## application
Find the values with the most leverage
* Sort the `.hat` to find the highly leveraged values. *You are finding outliers programmatically*
* Programmatic approach:
	1. augment
	2. select the columns of interest
	3. arrange to get the top values

```
mdl_roach 
	augment()
	select(variable1, variable2, leverage = .hat)
	arrange(desc(leverage))
	head()
```