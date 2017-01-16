function J = computeLogCost(X, y, theta, lambda)

	m = length(y);

	hx = sigmoid(X, theta);
	
	% We're going to regularise this - but we don't include the weight for the bias unit.
	J = sum(-y.*log(hx)-((1-y).*log(1-hx)))/m + ((sum([0;theta(2:end)].^2))*(lambda/(2*m)));

end