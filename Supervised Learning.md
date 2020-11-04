# Type of prediction


|| Regression        | Classification                
-------|-------------------|---------------------------------------
 Outcome  | Continuous        | Class                                 
 Examples | Linear regression | Logistic regression, SVM, Naive Bayes
 

# Type of model

|	|Discriminative model	|Generative model
---|---------------------|--------------------
Goal |	Directly estimate $P(y/x)$ | Estimate $P(x/y)$ to then deduce $P(y/x)$
What's learned |	Decision boundary	|Probability distributions of the data
Illustration	|![[Pasted image 20201104000507.png]]|	![[Pasted image 20201104000534.png]]
Examples	|Regressions, SVMs|	GDA, Naive Bayes