function [predict_pos, predict_neg] = predictLogData(X, theta, threshold)
    
    m = size(X,1);
    predict_pos = [];
    predict_neg = [];
    
    hx = sigmoid(X, theta);
    for i = 1:m
        if (hx(i) > threshold)
            predict_pos(end + 1,:) = X(i,2:end); % ignore bias term
        else
            predict_neg(end + 1,:) = X(i,2:end); % ignore bias term
        end
    end

    predict_pos;
    predict_neg;
    
end