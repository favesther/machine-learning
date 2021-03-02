## Bernoulli distribution 0-1 分布
the probability:
$$Bern(x|\mu)=\mu^x(1−\mu)^{1-x}$$
in expotential family form:
$$P(x|\mu)=\exp\Big\{(\log\frac{\mu}{1-\mu}x+\log(1-\mu)\Big\}$$

[STA613/CBB540: Statistical methods in computational biology](http://www2.stat.duke.edu/~sayan/Sta613/2016/lec/lec_jan24.pdf)

## the logistic function
In the Bernoulli distribution, in the exponential family, note that the logit function (i.e., log odds function) maps the *mean parameter *vector, $\mu$, to the natural parameter, $\eta$ . The function that maps $\eta$ to $\mu$ is the logistic function.
	
$$\mu =E[Y|X,\theta]$$
$$\mu=\frac{1}{1+exp(-\theta^Tx)}$$

## [[log-likehood]] function
let $\eta=\theta^Tx$,
$$l(D|\theta)=\sum_{i=1}^n\left[y_i\log\mu_i+(1-y_i)\log(1-\mu_i)\right]$$


## charateristic function 特征函数 
$$\phi(t)=1+p(e^{it}-1)$$


	