% Set up example data
x = [1272; 1385; 1877; 1294; 873; 784; 801; 729; 422; 346];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];

% Initialise the extra column on x
m = length(x);
x = [(ones(m,1)),x];

% Plot the graph
plot(x(:,2),y,'rx','MarkerSize',10);
ylabel('Price in 1000s');
xlabel('Size in square feet');

% Initialise theta to some value: here we are guessing that for 
% y = mx + c, c is 0.7 and m is 0.1:
% y = 0.1x + 0.7
theta = [0.7; 0.1];

% Keep the previous plot visible
hold on; 

% Plot the predicted line, based on theta and how it transforms x
predicted_y = x*theta;
plot(x(:,2), predicted_y, '-')
legend('Training data', 'Linear regression');

hold on; 

% Illustrate the difference between the predicted value at y for the first example, 
% and the actual value of y from our example data
plot([x(1,2),x(1,2)],[predicted_y(1),y(1)],'-');

pause;
hold on;

% Now draw all of the other differences
for j = 2:m
	hold on;
	plot([x(:,2)(j),x(:,2)(j)],[predicted_y(j),y(j)], '-');
end