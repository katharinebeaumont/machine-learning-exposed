%--------------------------------------------------------%
%
% Here, we are going to show how the cost function looks
% different for different values of theta. Next see 
% gradientDescentExample.m for a more step-by-step look.
%
%--------------------------------------------------------%

% Set up the example data
x = [1272; 1385; 1877; 1294; 873; 784; 801; 729; 422; 346];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];
m = length(x);

X = [(ones(m,1)),x];
theta = [0.7; 0.1];
J=computeCost(X, y, theta);

% We are going to change theta1, '0.1', and see how this changes the
%  cost function. 
% We are looking at theta1, and not theta0 in this example, as 
%  theta0 represents the y intercept (c of y = mx + c) whereas
%  theta1 is the gradient (m of y = mx + c) and the one that directly
%  transforms the training data. We could also have looked at theta0.
iterations = 130
J_history = [J;zeros(iterations, 1)];
theta_history = [theta';zeros(iterations, length(theta))];
for i = 1:iterations
	theta = [0.7; theta(2)+0.001];
	theta_history(i+1,:) = theta;
	J_history(i+1) = computeCost(X, y, theta);
end

% Compare theta1 with the cost function values
plot(theta_history(:,2),J_history,'rx','MarkerSize',5);
ylabel('The Cost Function J');
xlabel('Theta1');
