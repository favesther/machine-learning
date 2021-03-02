non-linear
![[Pasted image 20201119183100.png]]
If the probability of survival is 75% then the odds of
survival is 3:1



## Odds ratio
![[Pasted image 20201119183326.png]]
Ratio of odds when explanatory variable increases by 1 unit. Mathematically equal to the exponential of beta1, i.e., the slope coefficient

`exp(coef(mod))`

```r
coef(model) %>% exp() %>% round(2)
```