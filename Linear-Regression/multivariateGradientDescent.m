%--------------------------------------------------------%
% For multivariate gradient descent, we simultaneously 
% change the theta values and look at how all of them 
% affect the cost function. Let's imagine we also know the
% number of bedrooms for each example
%
% This is a step-by-step example of how the steps in 
% gradient descent work.
%--------------------------------------------------------%

x = [1272, 4; 1385, 4; 1877, 4; 1294, 3; 873, 3; 784, 3; 801, 2; 729, 2; 422, 1; 346, 1];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];
m = length(y);

X = [(ones(m,1)),x];
theta = [0.7; 0.1; 1];
J=computeCost(X, y, theta);


alpha = 0.000001;
iterations = 100;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);
