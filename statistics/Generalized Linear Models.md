## Exponential family
* $\eta$ - a natural parameter(the canonical parameter or link function
* $T(x)$ - a sufficient statistic
* $a(\eta)$ - a log-partition function

$$\boxed{p(y;\eta)=b(y)\exp(\eta T(y)-a(\eta))}
$$
>Remark: we will often have $T(y)=y$. Also,$\exp(-a(\eta))$ can be seen as a normalization parameter that will make sure that the probabilities sum to one.

The most common exponential distributions are summed up in the following table:

Distribution|	$\eta$	|$T(y)$|	$a(\eta)$|	$b(y)$
:---:|:---:|:---:|:---:|:---:
Bernoulli|	$\log\left(\frac{\phi}{1-\phi}\right)$|$y$|	$\log(1+\exp(\eta))$|$1$
Gaussian|	$\mu$|	$y$	|$\frac{\eta^2}{2}$|$\frac{1}{\sqrt{2\pi}}\exp\left(-\frac{y^2}{2}\right)$
Poisson	|$\log(\lambda)log(λ)$|	$y$|	$e^{\eta}$|$\displaystyle\frac{1}{y!}$
Geometric|$\log(1-\phi)$|$y$|$\log\left(\frac{e^\eta}{1-e^\eta}\right)$|$1$


## Assumptions of GLMs
Generalized Linear Models (GLM) to predict a random variable $y$ using a function of $x$ with three assumptions:
1. $\quad\boxed{y|x;\theta\sim\textrm{ExpFamily}(\eta)}$
2. $\quad\boxed{h_\theta(x)=E[y|x;\theta]}$
3. $\quad\boxed{\eta=\theta^Tx}$ 

>Remark: ordinary least squares and logistic regression are special cases of generalized linear models.