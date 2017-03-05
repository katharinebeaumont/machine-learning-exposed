%--------------------------------------------------------%
% Sometimes the best fit to data isn't a straight line. In
% this example there are a few more examples that look like
% a straight line won't be accurate for a line of best fit.
% 
% Here we create an extra variable by squaring x, so X is a
% matrix that contains the bias (a column of 1s), the size
% in square feet, and the size in sqaure feet squared, then
% scaled.
%
% We are assuming that the hypothesis looks more like
%   h(x) = theta0 + theta1*x + theta2*x^2
%
% NB: the example data has been amended to it better suits
% a polynomial line of best fit.
%--------------------------------------------------------%

close all;
x = [1910; 1900; 1880; 1870; 1900; 1800; 1272; 1385; 1294; 873; 784; 801; 729; 680; 422; 346; 100];
y = [600; 600; 580; 555; 450; 500; 355; 290; 255; 125; 110; 100; 60; 80; 55; 45; 41];

m = length(x);
X = [(ones(m,1)),x,((x.^2)/100)];

% This is to help visualise the hypothesis on the graph
x_range = [0: 20: 2000]';
X_range = [(ones(length(x_range),1)),x_range,((x_range.^2)/100)];

% Plot the example data
plot(x,y,'rx','MarkerSize',10), grid on, ylabel('Price in 1000s'), xlabel('Size in square feet'), title('House price examples');
hold on;

% Start off with some theta values, and ploy the initial line of best fit
theta = [0.7; 0; 0.01];
J = computeCost(X, y, theta);

format shortG;
disp('Press enter to plot the initial line of best fit.');
pause;

disp('Theta is:');
disp(theta);
disp('Cost function: ');
disp(J);

plot(x_range,X_range*theta,'-');

% Set the learning rate
alpha = 0.0000000001;
iterations = 1000;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);

disp('Press enter to plot the line of best fit once Gradient Descent has run.');
pause;

disp('Theta is:');
disp(theta);
disp('Cost function: ');
disp(J_history(iterations));


% See the hypothesis once gradient descent has optimised theta values
plot(x_range,X_range*theta,'-'),legend('Example data', 'Initial Line of Best Fit [hypothesis]', 'Line of Best Fit after gradient descent');