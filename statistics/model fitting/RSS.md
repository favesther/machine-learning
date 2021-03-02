**residual sum of squares**
$$RSS=e_1^2+e_2^2+...+e_n^2$$

also SS

# SSE
standard squared error

```r
# calculate SSE
model %>% 
  augment(variable) %>% 
  summarise(SSE = sum(.resid ^ 2))
```