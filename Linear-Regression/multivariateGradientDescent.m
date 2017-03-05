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

fprintf('Visualizing J(theta1, theta2) ...\n')

% Grid over which we will calculate J
iterations = 100;
theta1_vals = linspace(0, 0.3, iterations);
theta2_vals = linspace(2, 3, iterations);

% Initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta1_vals), length(theta2_vals));

% Fill out J_vals - we want to know what the cost function is for every
% combination of thetas
for i = 1:iterations
    for j = 1:length(theta2_vals)
	  t = [theta1_vals(i); theta2_vals(j)];    
	  J_vals(i,j) = computeCost(X(:,2:3), y, t);
    end
end


% Because of the way meshgrids work in the surf command, we need to 
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
figure;
surf(theta1_vals, theta2_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1');