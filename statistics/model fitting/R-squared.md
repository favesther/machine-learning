<font color='orange'>R-squared is the measure of the quality of the fit of a regression model</font>


### Compute [[R-squared]]
```
augment(mdl_price_vs_conv) %>%
  summarize(var_y = var(price_twd_msq), var_e = var(.resid)) %>%
  mutate(R_squared = 1 -  var_e/var_y)	
```
 

## $R^2$ interpretation: 
Our model based on tail length explains about 32% variability in body length for these possums.

## Over reliance on $R^2$
While high R2 is better,
* A model with high R2 doesn’t alone mean that the model fit is good. There could be overfitting.
* A model with a low R2 can still be useful and provide statistically significant insight. Determinig what is low also depends on the context of the domain (e.g. human behavior modeling quite hard and low * R2 might still be good).

## R-squared vs. adjusted R-squared

### R-squared

Coefficient of determination
$$R^2=1-\frac{SSE}{SST}$$
As SSE gets smaller, R2 gets higher (generally denoting a higher model fit)
Issue with R2 is that the SSE can only decrease as new variables are added to the model, while the SST does not change. So you can increase R2 by adding any additional variable—even random noise <font color='yellow'>(More of an issue in multiple linear regression.)</font>

Ratio of SSE of linear by null explains the** variability in the response variable**.
By building a regression model, we hope to explain some of that variability. The portion of the SST variability that is not explained by our model is the SSE

### adjusted R-squared
$$R^2=1-\frac{SSE}{SST}\cdot\frac{n-1}{n-p-1}$$
Adjusted R2 penalizes a model for each additional explanatory variable (where p is the number of explanatory variables)

* Adjusted R2 can be interpreted as an unbiased (or less biased) estimator of the population R2
* Adjusted R2 is more appropriate when evaluating model fit (the variance in the dependent variable accounted for by the independent variables)
> Here we have an adjusted R-squared of 0.1737, meaning that only about 17% of the variance in salary can be explained by yrs.since.phd. 