Indicator or dummy variable
<font color='red'>Categorical variable with K levels will need K - 1 dummy variables</font>

## Predictor with 2 levels
$\beta_0$ Interpreted as the average price of the game when game is used (baseline or reference value)
$\beta_1$ Average difference in the price for new game in comparison to used games (always interpret in comparison to baseline)
$\beta_0+\beta_1$ Interpreted as the average price of the game when game is new

## Predictors with more than 2 levels
![[Pasted image 20201117205837.png]]
* $\beta_0$ Can be interpreted as the average credit card balance for African Americans(baseline or reference value)
* $\beta_1$ Difference in the average balance between the Asian and African American
* $\beta_2$ Difference in the average balance between the Caucasian and African American

## interaction
The effect of one explanatory variable on the expected response changes depending on the value of another explanatory variable.

### Multiple regression - Including interaction terms
$$y=\beta_0+\beta_1X_1+\beta_2X_2+\beta_3X_1X_2+\epsilon$$
*  $\beta3$ is the increase in the effectiveness of TV advertising for a one unit increase in radio advertising (or vice-versa)
* implicit syntax
`response_var ~ explntry1 * explntry2` 
* explicit syntax
`response_var ~ explntry1 : explntry2`


### example
![[Pasted image 20201213012752.png]]|![[Pasted image 20201213012821.png]]
--|--
+ve slope (5-day) and significant: On average among the 5day auctions, every additional increase in open
bid is associated with an increase of final sale price
-ve slop (3 day): On average among the 3day auctions, every additional increase in open bid (2nd
explanatory variable) is associated with a decrease of final sale price
