function hx = sigmoid(X, theta)
	
	hx = 1 ./ (1 + exp(-X*theta));

end