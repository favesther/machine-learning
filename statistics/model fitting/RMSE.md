RMSE value interpretation: Our model makes a predicted body length that is typically within 3.57 centimeters of the truth

$$RMSE=\sqrt\frac{SSE}{n-2}$$


### code in R
```r
library(modelr)
rmse(model, data = )
```

### code in Python
```py
def compute_rmse(predictions, yvalues):
    rmse = np.sqrt(np.mean((predictions-yvalues)**2))
    return round(rmse, 2)
```

## MSE
mean-squared-error
`mean((Auto$mpg-pred)^2)`
