%--------------------------------------------------------%
% We're going to look at how the line of best fit compares
% with 3 different 'guesses' at what the constants in 
% y = mx + c
% are. We are going to call m and c theta, a vector of 
% length 2: [c; m] or [theta0; theta1].
% We will see the difference in the 'cost' of each example.
%--------------------------------------------------------%

function J = computeCost(X, y, theta)

m = length(y);

J=(sum(((X*theta) - y).^2))/(2*m);

end


% REMINDER: the cost function is
%
% 1                              2
% -- * The sum of:  ( h(x) - y )    for every training example
% 2m
%
%%% What does... (X*theta) do?
%  X is a matrix, with m rows, and n columns.
%  y is a vector, with n rows (and, as it's a vector, 1 column)
%  e.g. X (where m = 3 and n = 2)
%   1 1272
%   1 1385
%   1 1294
%  e.g. theta
%    0.7
%    0.1
% 
%  X*theta is a matrix multiplication. Each row of X is multiplied by
%   the column values of theta, so X*theta gets a vector answer= 
%   (1*0.7) + (1272*0.1) = 127.9
%   (1*0.7) + (1385*0.1)   139.2
%   (1*0.7) + (1294*0.1)   130.1
%
%  As a general rule, a mxn matrix * nxp matrix gets a mxp matrix answer
%   so as X is 3x2, and theta is 2x1, the resulting matrix is size 3x1
%  Matrix A must have the same rumber of columns as the row of matrix B
%   to be multipliable.
%
%%% What does... ((X*theta) - y) do?
%  Now we have a vector that represents X*theta, and it is the same
%  length as y. Taking away one vector (a) from another with the same length
%  (b) takes away the value of a at row i from the value of b at row i, so:
%
%  X*theta = 127.9  y = 355   X*theta - y = 127.9-355 = -227.1
%            139.2      290                 139.2-290   -150.8
%            130.1      290                 130.1-290   -101.6
%
%%% What does... ((X*theta) - y).^2 do?
%  The '.^' takes each value of the vector, and sqaures it.
%  If we have a vector like this:
%   a = 1  then a.^2 = 1
%       2              4
%       3              9
%       4             16
%
%%% What does... sum( ... ) do?
%  This adds each value of the vector to get a real number answer.
%  If a = 1  then sum(a) = (1+2+3+4) = 10
%         2
%         3
%         4