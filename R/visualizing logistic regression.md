```r
data_binned_space +
	geom_line(data = augemtn(model, type.predict = 'response'), 
				aes(y = .fitted), color = 'blue')
```

```r
data_space +
	geom_smooth(method = 'glm', se = FALSE, color = 'red'
				method.args = list(family = 'binomial'))
```

$$Y=p(X)=\frac{e^{\beta_0+\beta_1X}}{1+e^{\beta_0+\beta_1X}}$$