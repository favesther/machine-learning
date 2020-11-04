## likelihood 
to find the optimal $\theta$ through maximizing likelihood
$$\boxed{\theta^{\textrm{opt}}=\underset{\theta}{\textrm{arg max }}L(\theta)}$$
>Remark: in practice, we use the [[log-likelihood]] $$\ell(\theta)=\log(L(\theta))$$ which is easier to optimize.

## Newton's algorithm
find the $\theta$ that $\ell'(\theta)=0$
* update rule:
$$\boxed{\theta\leftarrow\theta-\frac{\ell'(\theta)}{\ell''(\theta)}}$$


### Newton-Raphson method
the multidimentional [[generalization]]
* update rule:
$$\theta\leftarrow\theta-\left(\nabla_\theta^2\ell(\theta)\right)^{-1}\nabla_\theta\ell(\theta)$$
