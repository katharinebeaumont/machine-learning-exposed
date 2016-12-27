
function J = showDifferencesForGuess(X, y, theta)
	
	% Plot the graph. We are looking at the second column of the matrix X here,
	%  because this is the one with the data. The first column, we initialised with
	%  1s so we can use matrices in our computation.
	plot(X(:,2),y,'rx','MarkerSize',10);
	ylabel('Price in 1000s');
	Xlabel('Size in square feet');

	% Keep the graph visible.
	hold on; 

	% Now, plot the predicted line, based on theta and how it transforms X
	fprintf('Theta is %d.', theta);

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

	% Illustrate the difference between the predicted value at y for the first example, 
	%  and the actual value of y for the first example.
	%  The final argument here '-' tells the plot function to draw a line between them.
	plot([X(1,2),X(1,2)],[predicted_y(1),y(1)],'-');

	disp('Press enter to see the differences for all of the training examples against the guessed');
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

	abs_difference_matrix = ones(m,3);
	for k = 1:m
		abs_difference_matrix(k,:) = [predicted_y(k),y(k),abs(predicted_y(k) - y(k))];
		sq_difference_matrix(k,:) = [predicted_y(k),y(k),(predicted_y(k) - y(k))^2];
	end

	disp('The following shows the absolute difference between the predicted values of y,');
	disp(' versus the actual values from the training examples');
	list_in_columns({"h(x)","   y","   Error"}, 45), disp("================================="), disp(abs_difference_matrix);

	disp('Press enter to show the squared difference.');
	hold on;
	pause;

	disp('The following shows the squared difference between the predicted values of y,');
	disp(' versus the actual values from the training examples');
	list_in_columns({"h(x)","   y","   Error"}, 45), disp("================================="), disp(sq_difference_matrix);

	J=(sum(sq_difference_matrix(:,3)))/(2*m);
	fprintf('The Cost Function J is %d', J);
end