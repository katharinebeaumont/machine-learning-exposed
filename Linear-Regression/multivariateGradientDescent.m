%--------------------------------------------------------%
% For multivariate gradient descent, we simultaneously 
% change the theta values and look at how all of them 
% affect the cost function. Let's imagine we also know the
% number of bedrooms for each example.
%
% Here we're just going to look at the bias term and the
% number of bedrooms.
% Why? Because there is more of an obvious effect when looking
% at how the Cost Function changes.
%--------------------------------------------------------%

% Close any open figures
close;

x = [1272, 5; 1385, 4; 1877, 4; 1294, 3; 873, 3; 784, 3; 801, 2; 729, 2; 422, 1; 346, 1];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];
m = length(y);

X = [(ones(m,1)),x];
% Work out with cost function with an initial guess at theta
theta = [-10; 0.1; 12];
J = computeCost(X, y, theta);
fprintf('Theta is: ');
fprintf('%d ', theta);
fprintf('\nCost Function is %d\n', J);

% Now run gradient descent
alpha = 0.000001;
iterations = 1000;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);
J = computeCost(X, y, theta);
disp('Cost for theta after gradient descent is: ');
disp(J);
disp('Theta is: ');
disp(theta);

fprintf('Visualizing J(theta1, theta3) with theta2 constant...\n')

% Grid over which we will calculate J
iterations = 100;
theta1_vals = linspace(-30, 30, iterations);
theta3_vals = linspace(1, 20, iterations);

% Initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta1_vals), length(theta3_vals));

% Fill out J_vals - we want to know what the cost function is for every
% combination of thetas
for i = 1:length(theta1_vals)
    for j = 1:length(theta3_vals)
	  t = [theta1_vals(i); theta(2); theta3_vals(j)];    
	  J_vals(i,j) = computeCost(X, y, t);
    end
end

% Because of the way meshgrids work in the surf command, we need to 
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
figure;
surf(theta1_vals, theta3_vals, J_vals)
xlabel('\theta_1'); ylabel('\theta_3'), zlabel('Cost Function');