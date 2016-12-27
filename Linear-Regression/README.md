## Linear Regression

In these examples we step through the basics of linear regression.
The first file is [linearRegGuess.m](https://github.com/katharinebeaumont/machine-learning-exposed/blob/master/Linear-Regression/linearRegGuess.m) which looks at fitting a line of best fit to some basic example data. We try with three different 'guesses' at the line of best fit, and look at what the 'cost' is for each - the difference between what we predict the y value is (using the line of best fit) versus the example data we are trying to fit the line to.

As it is linear regression, and the equation of a straight line can be modelled as 'y = mx + c', we are looking for what the constants 'm' and 'c' could be. We know x and y, but how do we transform x to get y?
In the files, the constants 'm' and 'c' are represented as a vector, 'theta', which has 2 rows, one for 'c' (theta0) and one for 'm' (theta1). This makes some of the computations easier.

In [costFunction.m](https://github.com/katharinebeaumont/machine-learning-exposed/blob/master/Linear-Regression/costFunction.m) we look at how changing one of the parameters (theta1, 'm') affects the 'cost' of the predicted line of best fit.