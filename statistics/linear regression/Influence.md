
## description
Another type of outlier is when the point lies a long way from the model predictions
Influence measures how much the model would change if you left the observation out of the dataset when modeling.
![[Pasted image 20201116171551.png]]
**Influence measures how much the model would change if you left the observation out of the dataset when modeling.**

## application
Find the values with the most influence
* Sort the `.cooksd` to find the highly leveraged values. *You are finding outliers programmatically*
* Programmatic approach:
	1. augment
	2. select the columns of interest
	3. arrange to get the top values

```
mdl_roach 
	augment()
	select(variable1, variable2, cooks_dist = .cooksd)
	arrange(desc(cooks_dist))
	head()
```