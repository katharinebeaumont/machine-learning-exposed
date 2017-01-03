%--------------------------------------------------------%
% In gradient descent, we take a starting point for theta
% and work out the cost. We can plot the cost function J
% against theta, and see how the cost changes with respect
% to theta. Gradient descent looks at whether the cost is
% increasing or decreasing, and adjusts theta accordingly.
%--------------------------------------------------------%


function [theta, theta_history, J_history] = gradientDescent(X, y, theta, alpha, iterations)

    % The size of our example data
    m = length(y);

    % We're going to keep track of how the cost function J changes 
    %  depending on the values of theta.
    J_history = zeros(iterations+1, 1);

    % We're going to keep track of how gradient descent changes the values
    %  of theta, so we can later plot theta against the cost function.
    theta_history = zeros(iterations+1, length(theta));

    % Initialise our J_history and theta_history matrices with the 
    %  first values.
    J_history(1) = computeCost(X, y, theta);
    theta_history(1,:) = theta';  

    for i = 1:iterations

        % We change each value of theta one at a time, and we don't want to set
        %  the new value of theta until we have calculated each of the elements.
        % This works for any number of theta values, calculating them one at a time,
        %  and then setting the new values once all of them have been calculated.
        new_theta = zeros(size(theta));
        for j = 1:length(theta)
            new_theta(j) = theta(j) - (alpha/m)*sum((X*theta - y).*X(:,j));
        end

        % Save the cost J in every iteration, and the corresponding value of theta.
        %  We're doing 'i+1' here because we want the first and last values (which will
        %  be length i+1)
        theta_history((i+1),:) = new_theta'; 
        theta = new_theta;
        J_history(i+1) = computeCost(X, y, theta);
        
    end


end