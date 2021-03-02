# Linear regression
assume $y|x;\theta\sim\mathcal{N}(\mu,\sigma^2)$
the error terms have a constant variance

## Normal equations
$X$ is the design matrix
* to find $\theta$ that minimizes the [[cost function]], this is a closed form solution	
	$$\boxed{\theta=(X^TX)^{-1}X^Ty}$$

## LMS algorithm

>the Widrow-Hoff learning rule

the update rule of the **Least Mean Squares** ( #LMS) algorithm for a training set of $m$ data points

$$\boxed{\forall j,\quad \theta_j \leftarrow \theta_j+\alpha\sum_{i=1}^m\left[y^{(i)}-h_\theta(x^{(i)})\right]x_j^{(i)}}$$
	
==a particular case of the gradient ascent==

### LWR - Locally Weighted Regression
a variant of linear regression that **weights** each training example in its cost function by $w^{(i)}(x)$, which is defined with parameter $\tau\in\mathbb{R}$ 
$$\boxed{w^{(i)}(x)=\exp\left(-\frac{(x^{(i)}-x)^2}{2\tau^2}\right)}$$