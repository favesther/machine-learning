Leave-One-Out Cross-Validation

```r
# LOOCV can be done with the cv.glm function in the boot package
library(boot)
# ?cv.glm

# Compute LOOCV estimate of the test MSE
cv.err <- cv.glm(Auto, glm.fit)

# Resulting object contains many different things
names(cv.err)

# Two numbers in the delta vector contain cv results. 
# Exactly equal for LOOCV. The second is a bias corrected version
cv.err$delta
```
