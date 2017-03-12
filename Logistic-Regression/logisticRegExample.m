% We have some positive examples and negative examples.
% The negative examples are illustrated on the graph as red squares.
% The positive examples are green circles.


% Close any open graphs
close all;

% This is the output: 0 is negative, 1 is positive.
% The first four examples are negative. The next four are positive.
y = [0;0;0;0;1;1;1;1];

negative_examples = [1,1;1,2;2,1;2,2];
positive_examples = [4,4;4,3;3,4;3,3];

X = [negative_examples;positive_examples];

% This sets the axis of the graph so it is one larger than our smallest and largest
% values, to make it easier to see the shapes on the graph.
axis_of_plot = [min(X(:,1))-1;max(X(:,1))+1;min(X(:,2))-1;max(X(:,2))+1];
figure(1), axis(axis_of_plot), hold on;
figure(2), axis(axis_of_plot), hold on;
figure(1), title('Classification problem: positive and negative examples');
figure(1), plot(positive_examples(:,1),positive_examples(:,2),'o','markersize',10,'color','g'), hold on;
figure(1), plot(negative_examples(:,1),negative_examples(:,2),'s','markersize',10,'color','r');

m = length(y);
% Add a bias value of 1 to the X values
X = [(ones(m,1)),X];

% Intialise theta to some values
theta = [rand;rand;rand];
	
[theta, theta_history, J_history] = gradientDescentLog(X, y, theta, 0.1, 1000, 1);
J = computeLogCost(X, y, theta, 1);

fprintf('After gradient descent, theta is: ');
fprintf('%d ', theta);
fprintf('\n');
fprintf('And the error or cost is: ');
fprintf('%d ', J);
fprintf('\n');
figure(3); plot(J_history); xlabel('Iterations'); ylabel('Cost'); title('Cost Function history')

% Now, using the new theta... will it correctly classify as positive or negative?
threshold = 0.5;
predicted_positive_examples = [];
predicted_negative_examples = [];
predicted_output = sigmoid(X,theta);
for i = 1:m
	if (predicted_output(i) > threshold)
		predicted_positive_examples(end + 1,:) = X(i,2:3);
	else
		predicted_negative_examples(end + 1,:) = X(i,2:3);
	end
end

% How many answers are correct or incorrect?

% Display the predicted results
figure(2), plot(predicted_positive_examples(:,1),predicted_positive_examples(:,2),'o','markersize',10,'color','g');
figure(2), hold on;
figure(2), title('Classification problem: predicted spositive and negative examples');
figure(2), plot(predicted_negative_examples(:,1),predicted_negative_examples(:,2),'s','markersize',10,'color','r');

