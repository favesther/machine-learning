residual standard error : difference b/w a prediction and an observed response, i.e., how much the predictions are typically wrong by.

the estimate of $\sigma^2$

### IMT 573
$$RSE=\sqrt\frac{RSS}{n-2}$$

```r
# RSE in glance
glance(model)$sigma
```

## statistics
RSE is the square root of $$RSE=\frac{RSS}{degrees\space of\space freedom}$$
$$RSE=\sqrt\frac{RSS}{n-p-1}$$
