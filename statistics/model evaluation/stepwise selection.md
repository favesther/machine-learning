> Best subset selection — lots of models to navigate, impractical for large $p$

`MASS::stepAIC`  [[stepAIC]]function

[[AIC]]
Stepwise selection will iteratively add predictors that decrease an information criterion and/or remove those that increase it, depending on the mode of stepwise search that is performed.

```r
modelAIC <- MASS::stepAIC(model, k = 2)
```

<font color='pink'>set it to k = log(n), the function considers the </font>[[BIC]].