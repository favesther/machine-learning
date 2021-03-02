## returns [[statistics/model fitting/coefficients]] results in a dataframe
`tidy(mdl_price_vs_conv) `	
	
## returns observation level results in a dataframe
`augment(mdl_price_vs_conv)` 


## returns model level results
`glance(mdl_price_vs_conv) `

### First build [[Null model]]
```
mod_null <- lm(price_twd_msq ~ 1, data = taiwan_real_estate)
```

