%--------------------------------------------------------%
% Test error:
%
% We're going to look at how many training examples a 
% hypothesis correctly predicts. This is also a function, 
% taking lambda as a variable, so we can see how changing
% lambda changes the data.
%--------------------------------------------------------%

function testError(lambda)
% We have some positive examples and negative examples.
% The negative examples are illustrated on the graph as red squares.
% The positive examples are green circles.

%Set lambda (the regularisation term) if it isn't already
if ~exist('lambda','var')
    lambda = 1;
end
    
% Close any open graphs
close all;

negative_examples = [1,1;1,2;2,1;2,2;3,3;2,3;3,2;1,5;1,6;2,4;0,1;0,0;6,1;4,0;3,0];
positive_examples = [4,4;4,3;3,4;4,5;5,4;5,5;5,6;5,3;4,5;5,4;7,6;7,7;6,7;7,4;4,7];
y_all = [zeros(length(negative_examples),1);ones(length(positive_examples),1)];
m_all = length(y_all);
X_all = [negative_examples;positive_examples];

% Display data
% axis_of_plot sets the axis of the graph so it is one larger than our smallest and largest
% values, to make it easier to see the shapes on the graph.
axis_of_plot = [min(X_all(:,1))-1;max(X_all(:,1))+1;min(X_all(:,2))-1;max(X_all(:,2))+1];
subplot(2,2,1), axis(axis_of_plot), hold on, title('Training set data');
subplot(2,2,2), axis(axis_of_plot), hold on, title('Predicted output before gradient descent');

subplot(2,2,1), plot(positive_examples(:,1),positive_examples(:,2),'o','markersize',10,'color','g'), hold on;
subplot(2,2,1), plot(negative_examples(:,1),negative_examples(:,2),'s','markersize',10,'color','r');
disp('Classification example: actual output (green = positive, red = negative).');
disp('Press enter to randomly initialise theta and work out the cost and error.');
pause;

% Add a bias value of 1 to the X values
X_all = [(ones(m_all,1)),X_all];
% Set a threshold. If h(x) > threshold, predict 1.
% If h(x) <= threshold, predict 0.
threshold = 0.5;

% Now we're going to randomly shuffle the data, which will help when we
% take a sample for training, and a sample for the test set.
% randperm gives us a matrix with 1 row, m_all columns with numbers 1-m_all
% in a random order.
index_reshuffle = randperm(m_all);
% We then get the rows from X_all, in the reshuffled order
X_all = X_all(index_reshuffle,:);
% and do the same to y_all so that the input and output values are in
% matching orders.
y_all = y_all(index_reshuffle,:); 

% We're going to take the first 70% of each to be the training set, 
% and the last 30% to be the test set.
m_test = round(0.3*m_all);
m_train = m_all - m_test;
X_train = X_all(1:m_train,:);
y_train = y_all(1:m_train,:);
X_test = X_all(m_train+1:m_all,:);
y_test = y_all(m_train+1:m_all,:);

% Intialise theta to some values
theta = [rand;rand;rand];
disp('Theta is: ');
disp(theta);

% Before we run gradient descent, let's work out the error.
J_train = computeLogCost(X_train, y_train, theta, 1);
J_test = computeLogCost(X_test, y_test, theta, 1);
test_error = computeLogError(X_test, y_test, theta, threshold);
disp('Before running gradient descent, J_train is: ');
disp(J_train);
disp('and J_test is: ');
disp(J_test);
disp('and error on the test data is: ');
disp(test_error);
disp('Press enter to visualise the data.');
pause;

% We might have all positive or all negative at this point.
[pos_before_gd, neg_before_gd] = predictLogData(X_all, theta, threshold);
if ~isempty(pos_before_gd)
    subplot(2,2,2), plot(pos_before_gd(:,1),pos_before_gd(:,2),'o','markersize',10,'color','g'), hold on;
end
if ~isempty(neg_before_gd)
    subplot(2,2,2), plot(neg_before_gd(:,1),neg_before_gd(:,2),'s','markersize',10,'color','r'), hold on;
end

disp('Press enter to continue.');
pause;

% Now run gradient descent, but not across all the data, just the 70%
% training data. We can then test it on the test set.
iterations = 1000;
learning_rate = 0.1;
[theta, theta_history, J_history] = gradientDescentLog(X_train, y_train, theta, learning_rate, iterations, lambda);
J_train = computeLogCost(X_train, y_train, theta, 1);
J_test = computeLogCost(X_test, y_test, theta, 1);
disp('After running gradient descent on the training set for iterations: ');
disp(iterations);
disp('Learning rate: ');
disp(learning_rate);
disp('And lambda [regularisation term]: ');
disp(lambda);

disp('J_train is: ');
disp(J_train);
disp('and J_test is: ');
disp(J_test);

% What proportion of answers are correct or incorrect?
test_error = computeLogError(X_test, y_test, theta, threshold);
disp('The error on the test data is: ');
disp(test_error);
total_error = computeLogError(X_all, y_all, theta, threshold);
disp('Error percentage: ');
disp(total_error*100);

% Display the predicted results, after gradient descent
[pos_after_gd, neg_after_gd] = predictLogData(X_all, theta, threshold);

subplot(2,2,3), axis(axis_of_plot), hold on, title('Predicted output after gradient descent');
if ~isempty(pos_after_gd)
    subplot(2,2,3), plot(pos_after_gd(:,1),pos_after_gd(:,2),'o','markersize',10,'color','g'), hold on;
end
if ~isempty(neg_after_gd)
    subplot(2,2,3), plot(neg_after_gd(:,1),neg_after_gd(:,2),'s','markersize',10,'color','r'), hold on;
end

disp('Press enter to see the Cost Function changing over time.');
pause;

figure(2), plot(J_history); xlabel('Iterations'); ylabel('Cost'); title('Cost Function history')

end