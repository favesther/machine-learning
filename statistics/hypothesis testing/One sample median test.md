## One sample median test
Test whether a sample median differs significantly from a hypothesized value.


### example
question: Test whether the median writing score (write) differs significantly from 50.

* Hypothesis Testing:
	* H0: Median of writing score = 50
	* Ha: Median of writing score $\neq$ 50
* Check your test statistic
	* Level of significance = p-value
	* If p-value < 0.05, reject NULL hypothesis

`wilcox.test(write, mu = 50)`