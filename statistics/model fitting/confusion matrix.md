![[Pasted image 20201119185019.png]]
Model predicted that 91 (71+20) would die, and only 12 (4+8) would live.
Of those 91, actually dies is 71, while of the 12, actually lived is 8.

Overall Accuracy:
79/103 = 77%


```r
library(SDMTools)
confMatrixNew <- confusion.matrix(variableA, variableB, threshold = 0.5)
```

* True negative: A classification is correct if it predicts an observation to be 0 where its true value is 0.
* True positive: A classification is also correct if it predicts an observation to be 1 where its true value is 1.

Prediction\Truth|negative|positive
---|---|---
negative|true-negative|false-negative
positive|false-positive|true-positive

In all other cases the prediction is wrong and observations are misclassified.

## accuracy
<font color='orange'>Accurate along the diagonals of confusion matrix</font>

```r
sum(dia(confMatrixNew))/sum(confMatrixNew)
```

Finding optimal threshold