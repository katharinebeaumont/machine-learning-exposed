% We have some positive examples and negative examples 

close all;

y = [0;0;0;0;1;1;1;1];
negative_examples = [1,1;1,2;2,1;2,2];
positive_examples = [4,4;4,3;3,4;3,3];

X = [negative_examples;positive_examples];

axis_of_plot = [min(X(:,1))-1;max(X(:,1))+1;min(X(:,2))-1;max(X(:,2))+1];
figure(1), axis(axis_of_plot), hold on;
figure(2), axis(axis_of_plot), hold on;
figure(1), plot(positive_examples(:,1),positive_examples(:,2),'o','markersize',10,'color','g'), hold on;
figure(1), plot(negative_examples(:,1),negative_examples(:,2),'s','markersize',10,'color','r');

% Add a bias
m = length(y);
X = [(ones(m,1)),X];

% Intialise theta to some values
theta = [1;1;2];

% Work out the initial cost
J = computeLogCost(X, y, theta, 1);
% PRINT COST

[theta, theta_history, J_history] = gradientDescentLog(X, y, theta, 0.1, 1000, 1);
% PRINT theta
% PRINT COST
% PRINT graph of theta and cost function changing over time

% Now, using the new theta... will it correctly classify as positive or negative?
predicted_positive_examples = [];
predicted_negative_examples = [];
predicted_output = sigmoid(X,theta);
for i = 1:m
	if (predicted_output(i) > 0.5)
		predicted_positive_examples(end + 1,:) = X(i,2:3);
	else
		predicted_negative_examples(end + 1,:) = X(i,2:3);
	end
end

% Work out if it is correct or incorrect
figure(2), plot(predicted_positive_examples(:,1),predicted_positive_examples(:,2),'o','markersize',10,'color','g');
figure(2), hold on;
figure(2), plot(predicted_negative_examples(:,1),predicted_negative_examples(:,2),'s','markersize',10,'color','r');
% PRINT FINAL COST
