function J = computeLogCost(X, y, theta, lambda)

	m = length(y);

	hx = sigmoid(X, theta);
	
	% We're going to regularise this - but we don't include the weight for the bias unit.
    reg_theta = [0;theta(2:end)];
    reg_constant = lambda/(2*m);
	J = sum(-y.*log(hx)-((1-y).*log(1-hx)))/m + ((sum(reg_theta.^2))*reg_constant);

end