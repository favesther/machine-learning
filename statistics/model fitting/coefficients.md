Regression key question: Is there a relation between the response and the explanatory variable?

we compute a t-statistic to determine whether we can reject $H_0$. Check p-value

When there is no relationship between the response and predictors, one would expect the F-statistic to take on a value close to 1.

* We interpret βi as the average effect on Y of a one unit increase in Xi, holding all other predictors fixed.
* When interpreting coefficients, always include the phrase: holding all other predictors fixed or controlling for all other predictors* 

## Assessing Coefficients
`coef()`

## categorical predictor interpretation
### binary
![[Pasted image 20201214163933.png]]
* The average credit card debt for males is estimated to be $509.80, whereas females are estimated to carry $19.73 in additional debt for a total of $509.80 + $19.73 = $529.53.
* However, we notice that the p-value for the dummy variable is very high. This indicates that there is no statistical evidence of a difference in average credit card balance between the genders.

### multiple
![[Pasted image 20201214164721.png]]
From Table 3.8, we see that the estimated balance for the baseline, African American, is $531.00. It is estimated that the Asian category will have $18.69 less debt than the African American category, and that the Caucasian category will have $12.50 less debt than the African American category. However, the p-values associated with the coefficient estimates for the two dummy variables are very large, suggesting no statistical evidence of a real difference in credit card balance between the ethnicities.

### interaction
![[Pasted image 20201214173111.png]]
* The results in Table 3.9 strongly suggest that the model that includes the interaction term is superior to the model that contains only main effects.
* The p-value for the interaction term, TV×radio, is extremely low, indicating that there is strong evidence for Ha : β3 ≠ 0. In other words, it is clear that the true relationship is not additive. The R2 for the model (3.33) is 96.8%, compared to only 89.7% for the model that predicts sales using TV and radio without an interaction term. This means that (96.8 − 89.7)/(100 − 89.7) = 69% of the variability in sales that remains after fitting the additive model has been explained by the interaction term. 
* The coefficient estimates in Table 3.9 suggest that an increase in TV advertising of $1,000 is associated with increased sales of ( ˆ β1+ ˆβ3×radio)×1,000 = 19+1.1×radio units. And an increase in radio advertising of $1,000 will be associated with an increase in sales of ( ˆ β2 + ˆ β3 × TV) × 1,000 = 29 + 1.1 × TV units.