function error = computeLogError(X, y, theta, threshold)

    error_count = 0;
    m = length(y);
    
    hx = sigmoid(X, theta);
    
    for i = 1:m
        % We predict 1, 
        if (hx(i) > threshold)
            % but the target / actual output is 0
            if (y(i) == 0)
                error_count = error_count + 1;
            end
        else
            % We predict 0, 
            if (y(i) == 1)
                %but the target / actual output is 1
                error_count = error_count + 1;
            end
        end
    end
    
    error = error_count / m;
end