function [theta, theta_history, J_history] = gradientDescentLog(X, y, theta, alpha, iterations, lambda)

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
    J_history(1) = computeLogCost(X, y, theta, lambda);
    theta_history(1,:) = theta';  

    for i = 1:iterations

        % We change each value of theta one at a time, and we don't want to set
        %  the new value of theta until we have calculated each of the elements.
        % This works for any number of theta values, calculating them one at a time,
        %  and then setting the new values once all of them have been calculated.
        hx = sigmoid(X, theta);
        new_theta = zeros(size(theta));
        % When we regularise gradient descent for logistic regression, we don't include the
        %  bias value for theta
        reg_theta = [0;theta(2:end)];
        for j = 1:length(theta)
            % We need to add regularisation to this
            new_theta(j) = theta(j) - ((alpha/m)*sum((hx - y).*X(:,j)) + (lambda*reg_theta(j)/m));
        end

        % Save the cost J in every iteration, and the corresponding value of theta.
        %  We're doing 'i+1' here because we want the first and last values (which will
        %  be length i+1)
        theta_history((i+1),:) = new_theta'; 
        theta = new_theta;
        J_history(i+1) = computeLogCost(X, y, theta, lambda);
        
    end


end