# Variance Inflation Factors (VIF)

package `rms`

* VIFs: To systematically check all variables in a model for multicollinearity
* VIF values indicate the increase in the variance of an estimated coefficient due to multicollinearity.
* A VIF > 5 is problematic and values > 10 indicate poor regression estimates.

大不好
<font color='orange'>Exclude one of each correlated pairs and then build regression</font>