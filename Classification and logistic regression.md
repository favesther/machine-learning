##  [[Sigmoid]] function
$g$ logistic function
$$\forall z\in\mathbb{R},\quad\boxed{g(z)=\frac{1}{1+e^{-z}}\in[0,1]}$$

## [[logistic regression]]
assume bernoulli distribution:  $y|x;\theta\sim\textrm{Bernoulli}(\phi)$

$$\boxed{\phi=p(y=1|x;\theta)=\frac{1}{1+\exp(-\theta^Tx)}=g(\theta^Tx)}$$

> logistic regressions do not have closed form solutions.

## Softmax regression
* a multiclass logistic regression
* used to generalize logistic regression when there are more than 2 outcome classes

By convention, we set $\theta_K=0$ , which makes the Bernoulli parameter $\phi_i$  of each class $i$ be such that:

$$\boxed{\displaystyle\phi_i=\frac{\exp(\theta_i^Tx)}{\displaystyle\sum_{j=1}^K\exp(\theta_j^Tx)}}$$
