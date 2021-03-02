These three <font color=orange>diagnostic plots</font> are excellent for **sanity-checking** the quality of your models.

```
library(ggplot2)
library(ggfortify)

autoplot(model_object, which=???)
```

values for `which`
`1` residuals vs. fitted values
If you find equally spread residuals around a horizontal line without distinct patterns, that is a good indication you don’t have non-linear relationships.
horizontal line -> strong linearity
![[Pasted image 20201213020637.png]]
`2` [[Q-Q plot]]
`3` [[Scaled-location]]
`4` Residuals vs Leverage
This plot helps us to find influential cases if any.
This time patterns are not relevant. We watch out for outlying values at the upper right corner or at the lower right corner. Look for cases outside of a dashed line, Cook’s distance.
![[Pasted image 20201213193956.png]]

```r
# make diagnostic plots
par(mfrow=c(2,2)) # for readability
plot(model.all)
```