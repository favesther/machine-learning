* Occurs when one explanatory variable can be explained by the remaining explanatory variables.
* Regression coefficients become unstable and
* Standard errors reported by the linear model increases.

> The presence of collinearity can pose problems in the regression context, since it can be difficult to separate out the individual effects of collinear variables on the response.


### visualizing multicollinearity
```r
library(corrplot)
dataset %>%
	select(columns) %>%
	cor() %>%
	corrplot()
```