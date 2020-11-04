# loss function
$L:(z,y)\in\mathbb{R}\times Y\longmapsto L(z,y)\in\mathbb{R}$

input <- predicted value $z$ and real data $y$ 
values <span style=" color: yellow">**how different** </span> their outputs are

# common loss functions
Least squared error|	Logistic loss	|Hinge loss	|Cross-entropy
:--:|:--:|:--:|:--:
$\frac{1}{2}(y-z)^2$|$\log(1+\exp(-yz))$|$max(0,1-yx)$|$-\Big[y\log(z)+(1-y)\log(1-z)\Big]$
![[Pasted image 20201104002506.png]]|![[Pasted image 20201104002511.png]]|![[Pasted image 20201104002515.png]]|![[Pasted image 20201104002519.png]]|
Linear regression|	Logistic regression	|SVM|	Neural Network


