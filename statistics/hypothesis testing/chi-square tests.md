Categorical data

* **One-way chi-square test** (goodness of fit)
	* test for significance in the analysis of frequency distributions of a single nominal variable
* **Two-way chi-square test** (test of independence)
	* test for a relationship between two nominal variables

example:

Question: Is there a relationship between the type of school attended (schtyp) and student’s gender?
* Hypothesis Testing:
	* H0: schtype and gender are independent
	* Ha: schtype and gender are not independent
* Check your test statistic
	* Level of significance = p-value
	* If p-value < 0.05, reject NULL hypothesis
	
`chisq.test(table(female, schtyp))`


