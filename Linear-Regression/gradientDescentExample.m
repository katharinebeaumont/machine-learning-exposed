%--------------------------------------------------------%
% In gradient descent, we take a starting point for theta
% and work out the cost. We can plot the cost function J
% against theta, and see how the cost changes with respect
% to theta. Gradient descent looks at whether the cost is
% increasing or decreasing, and adjusts theta accordingly.
%
% This is a step-by-step example of how the steps in 
% gradient descent work.
%--------------------------------------------------------%

% Show single steps in gradient descent, 

% Set up example data again... this time, we are assuming that the hypothesis goes
%  through the origin, so there is no need to add a column of ones to X, and we only
%  have one theta, as we are only transforming the X data values.
clear all;
X = [1272; 1385; 1877; 1294; 873; 784; 801; 729; 422; 346];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];

m = length(y);
theta = [0.1];

figure(1), plot(X,y,'rx','MarkerSize',10), ylabel('Price in 1000s'), xlabel('Size in square feet'), title('House price examples');
figure(1), hold on;
% We're going to look at 5 different values of theta to begin with, and keep
%  track of them and the cost function at each point so we can plot them on a graph
theta_attempts = ones(5,1);
J_examples = ones(5,1);

gradient = (1/m)*sum(X*theta - y);
J=computeCost(X, y, theta);
theta_attempts(1) = theta; %indexing in Octave/Matlab starts from 1, not 0
J_examples(1) = J;
figure(1), plot(X,X*theta,'-'), hold on;
disp('Line of best fit with theta = 0.1. Press enter to continue.');
pause;
% J =  4461.0
% gradient = -60.670 - so the cost function is decreasing, as theta is increasing. 
% If we increase theta, the cost function should decrease.

% Let's increase theta a little bit
theta = [0.101];
gradient = (1/m)*sum(X*theta - y);
J=computeCost(X, y, theta);
theta_attempts(2) = theta;
J_examples(2) = J;
figure(1), plot(X,X*theta,'-'), legend('0.101'), hold on;
disp('Line of best fit with theta = 0.101. Press enter to continue.');
pause;
% J =  4381.8
% gradient = -59.692 - the cost function is still decreasing
% The cost function is smaller. Let's try increasing theta by a larger amount.

theta = [0.111];
gradient = (1/m)*sum(X*theta - y);
J=computeCost(X, y, theta);
theta_attempts(3) = theta;
J_examples(3) = J;
figure(1), plot(X,X*theta,'-'), hold on;
disp('Line of best fit with theta = 0.111. Press enter to continue.');
pause;
% J =  3653.3
% gradient = -49.909 
% The cost function is much smaller again, so we can try increasing theta by a larger amount

theta = [0.211];
gradient = (1/m)*sum(X*theta - y);
J=computeCost(X, y, theta);
theta_attempts(4) = theta;
J_examples(4) = J;
figure(1), plot(X,X*theta,'-'), hold on;
disp('Line of best fit with theta = 0.211. Press enter to continue.');
pause;
% J =  2738.4
% gradient = 47.921
% Now the cost function is smaller, but the gradient is positive, meaning that the cost
% function is increasing as theta increases. If we increase theta again, we will now
% see the cost function increase too:

theta = [0.221];
gradient = (1/m)*sum(X*theta - y);
J=computeCost(X, y, theta);
theta_attempts(5) = theta;
J_examples(5) = J;
figure(1), plot(X,X*theta,'-'), hold on;
disp('Line of best fit with theta = 0.221. Press enter to continue.');
pause;
% J =  3283.9
% gradient = 57.704
% So the optimum value for theta is between 0.211 and 0.111

disp('Press enter to see a graph of the results.');
pause;

figure(2), plot(theta_attempts, J_examples, '-');
xlabel('theta');
ylabel('Cost Function');
title('Theta changing the Cost Function');

% Now we're going to reset the example, and look at how gradient descent calculates
%  the theta values.

% Remember: in gradient descent we change theta a little bit each time, and we can 
% control how much / how little this is by adding a factor: alpha. Here, as theta is small
% and we are looking between 0.211 and 0.111, we don't want to change theta by a lot each time
% - we only want little steps.
% In gradient descent with one variable (one theta), we look at
% 
% new_theta = theta - (alpha/m)*sum(X*theta - y);
%
% As we've seen above, the gradients have been high (e.g. 57.704).
% If we change theta by too much each time, we might not find the minimum where the cost function
% is smallest. So we make alpha very small.
theta = [0.1];
alpha = 0.000001;
iterations = 100;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);
% theta =  0.16890
% Looking at theta_history and J_history the final cost function is 1712.1
% and it converges very quickly to the optimum value.

% Now we can see how the theta found by gradient descent fits the line of best fit to the data
disp('Press enter to see the line of best fit, using the theta value from gradient descent.');
pause;
figure(1), plot(X, X*theta, '-');
