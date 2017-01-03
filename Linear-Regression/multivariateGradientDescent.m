%--------------------------------------------------------%
% For multivariate gradient descent, we simultaneously 
% change the theta values and look at how all of them 
% affect the cost function. Let's imagine we also know the
% number of bedrooms for each example
% ... MORE DESC NEEDED, plus a visualisation of the data
%--------------------------------------------------------%

% Close any open figures
close;

x = [1272, 4; 1385, 4; 1877, 4; 1294, 3; 873, 3; 784, 3; 801, 2; 729, 2; 422, 1; 346, 1];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];
m = length(y);

X = [(ones(m,1)),x];
% Work out with cost function with an initial guess at theta
theta = [0.7; 0.1; 2];
J = computeCost(X, y, theta);
fprintf('Theta is: ');
fprintf('%d ', theta);
fprintf('\nCost Function is %d\n', J);

% Now run gradient descent
alpha = 0.000001;
iterations = 1000;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);
J = computeCost(X, y, theta);
fprintf('Cost for theta after gradient descent is %d\n', J);
fprintf('Theta is: ');
fprintf('%d ', theta);
