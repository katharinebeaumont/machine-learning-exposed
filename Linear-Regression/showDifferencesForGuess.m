%--------------------------------------------------------%
% This function will plot the example data, then the line
% of best fit with our guess at 'theta', the constants in
% y = mx + c. We will then visualise the differences between
% the example data, and the predicted line of best fit, 
% before working out the 'cost' of the predicted line of best
% fit - how 'correct' is it, for our example data?
%--------------------------------------------------------%

function showDifferencesForGuess(X, y, theta)
	
	% Plot the graph of the data. We are looking at the second column of the matrix X,
	%  because this is the one with the data. The first column, we initialised with
	%  1s so we can use matrices in our computation.
	plot(X(:,2),y,'rx','MarkerSize',10);
	ylabel('Price in 1000s');
	xlabel('Size in square feet');

	% Keep the graph visible.
	hold on; 

	fprintf('Theta is:');
	fprintf(' %d\n', theta);
	disp('Press enter to see the predicted line of best fit.');
	pause;

	% Now, plot the predicted line, based on theta and how it transforms X
	m = length(X);
	% predicted_y is what our hypothesis, y = (c*1) + (m*x), works out the y value as being.
	%  We can then compare this with the actual values of y.
	%  This computation takes each row of X, and multiplies the columns by theta. It adds
	%  them together, and the answer becomes an entry in the predicted y vector.
	%  So for the matrix X, and a theta vector [0.7; 0.1];
    %  Row 1:
	%     1  1272   *  0.7    = 1*0.7 + 1272*0.1 =  127.8
	%                  0.1
	predicted_y = X*theta;
	plot(X(:,2), predicted_y, '-')
	legend('Training data', 'Linear regression');

	hold on; 

	disp('Press enter to see the difference between one example and the predicted line of best fit.');
	pause;
	% Illustrate the difference between the predicted value at y for the first example, 
	%  and the actual value of y for the first example.
	%  The final argument here '-' tells the plot function to draw a line between them.
	plot([X(1,2),X(1,2)],[predicted_y(1),y(1)],'-');

	disp('Press enter to see the differences for all of the training examples against the predicted');
	disp(' line of best fit.');
	pause;

	hold on;

	% Now draw all of the other differences
	% and keep track of them so we can display them
	for j = 2:m
		hold on;
		%We are plotting the x value at each point (ignoring the bias)
		% against the predicted y, and the actual training example
		% to draw a line between them
		plot([X(:,2)(j),X(:,2)(j)],[predicted_y(j),y(j)], '-');
	end

	abs_difference_matrix = [predicted_y,y,abs(predicted_y - y)];
	sq_difference_matrix = [predicted_y,y,((predicted_y - y).^2)];

	disp('The following shows the absolute difference between the predicted values of y,');
	disp(' versus the actual values from the training examples');
	list_in_columns({"h(x)","   y","   Error"}, 45), disp("================================="), disp(abs_difference_matrix);

	disp('Press enter to show the squared difference.');
	hold on;
	pause;

	disp('The following shows the squared difference between the predicted values of y,');
	disp(' versus the actual values from the training examples');
	list_in_columns({"h(x)","   y","   Error"}, 45), disp("================================="), disp(sq_difference_matrix);

	% This is calculating the sum of all of the squared differences
	%  between the predicted line of best fit, and the actual y values
	%  from the data. We then take an average over all of the training
	%  examples, by dividing by m.
	J=(sum(sq_difference_matrix(:,3)))/(2*m);
	fprintf('For theta value:');
	fprintf(' %d', theta);
	fprintf(', the Cost Function J is %d', J);

end