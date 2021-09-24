   

Kimball four-step dimensional modeling process (top-down)

1. Select business process to model

2. Declare the [[grain]] of the business process

3. Choose the dimensions that apply to each fact row

4. Identify the numeric facts that will populate each row

## Why dimensional model  over normalized model
The dimensional model is easier for a business user to understand than a normalized data store because information is grouped into coherent business categories or dimensions that make sense to business people

## three types of columns
1. Keys (identifiers)
2. Attributes (properties of a dimension)
3. Measures (measurements at the interaction of dimensions)