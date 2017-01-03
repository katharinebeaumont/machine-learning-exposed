%--------------------------------------------------------%
% Sometimes the best fit to data isn't a straight line. In
% this example there are a few more examples that look like
% a straight line won't be accurate for a line of best fit.
% Here we create an extra variable by squaring x, so X is a
% matrix that contains the bias (a column of 1s), the size
% in square feet, and the size in sqaure feet squared, then
% scaled (see Feature Scaling in the notes for more information).
%
% ... MORE DESC NEEDED, plus a visualisation of the data
%--------------------------------------------------------%

close all;
x = [1910; 1900; 1880; 1870; 1900; 1800; 1272; 1385; 1877; 1294; 873; 784; 801; 729; 680; 422; 346; 100];
y = [600; 600; 580; 555; 450; 500; 355; 290; 290; 155; 125; 110; 100; 60; 80; 55; 45; 41];

m = length(x);
X = [(ones(m,1)),x,((x.^2)/100)];

plot(x,y,'rx','MarkerSize',10), ylabel('Price in 1000s'), xlabel('Size in square feet'), title('House price examples');
hold on;

theta = [0.7; 0.1; 0.01];
J=computeCost(X, y, theta);
plot(x,X*theta,'-');

alpha = 0.0000000001;
iterations = 1000;
[theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations);

% See the hypothesis once gradient descent has optimised theta values
plot(x,X*theta,'-'),legend('Example data', 'Initial Line of Best Fit [hypothesis]', 'Line of Best Fit after gradient descent');