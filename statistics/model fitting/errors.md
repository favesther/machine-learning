## residuals
$$\sum_{i=1}^{n}e_i^2$$
[[RSS]]=SSR=SSE
* RSS: Residual Sum of Squares
* SSR: Sum of Squared Residuals
* SSE: Sum of Squared Errors

## [[MSE]]
The Mean Squared Error (MSE) is the mean of RSS
$$MSE=\frac{RSS}{n}$$

## [[RMSE]]
The Root Mean Squared Error (RMSE) is the square root of MSE
$$RMSE=\sqrt{MSE}=\sqrt\frac{RSS}{n}$$

## [[RSE]]
The Residual Standard Error (RSE) is the square root of (RSS/degrees of freedom)
$$RSE=\sqrt\frac{RSS}{n-p-1}$$

## TSS
The Total Sum of Squares (TSS) is related with variance and not a metric on regression models
$$TSS=\sum_{i=1}^{n}(y_i-\bar y)^2$$
* where $\bar y$ is the sample mean
* further $var=\frac{TSS}{n-1}$

## [[R-squared]]
$$R^2=1-\frac{RSS}{TSS}$$
$$Adjusted\space R^2=1-\frac{RSS/(n-p-1)}{TSS/(n-1)}=1-\frac{RSE}{var}$$

## chain reaction
when it's getting overfitting (e.g. when there are more predictors, the model gets flexible):
* RSS ↓
	* MSE ↓
	* RMSE ↓
	* case when there are more predictors, we cannot know RSE increases or decreases
* TSS —
* R-squared ↑
* Adjusted R-squared : not sure. This is the why it's adjusted.