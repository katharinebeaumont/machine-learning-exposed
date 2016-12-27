%--------------------------------------------------------%
% We're going to look at how the line of best fit compares
% with 3 different 'guesses' at what the constants in 
% y = mx + c
% are. We are going to call m and c theta, a vector of 
% length 2: [c; m] or [theta0; theta1].
% We will see the difference in the 'cost' of each example.
%--------------------------------------------------------%

% Set up example data
x = [1272; 1385; 1877; 1294; 873; 784; 801; 729; 422; 346];
y = [355; 290; 290; 155; 125; 110; 100; 60; 55; 45];

% Initialise the extra column on x, so "y = mx + c"
%  is instead "y = (c*1) + (m*x)"
%  - this means that we can use a matrix X where the first column
%  has the value 1, and the second is the x value. This makes it easier to compute. 
%  The matrix will look like this:
%
%     1  1272
%     1  1385
%     1  1877
%     .  ...
%     1  346
%
%  It has 2 columns, and the number of rows = the length of x
m = length(x);
%  ones(m,1) initialises a matrix where every value is 1, and the size
%  is m rows and 1 column
X = [(ones(m,1)),x];

% Initialise theta to some value: here we are guessing that for 
% y = mx + c, c is 0.7 and m is 0.1:
%  Rearranging this to y = (c*1) + (m*x),
% y = (0.7*1) + (0.1*x)
theta = [0.7; 0.1];

% See the file 'showDifferencesForGuess.m' for details
showDifferencesForGuess(X, y, theta);

% Now let's try with another example
pause;
disp('Press enter to try with another guess');
% Clear down the previous plots
close all;

% We're going to keep the y intercept, c, the same, and change the 
%  gradient of the line, m to 0.2
% y = (0.7*1) + (0.2*x)
theta = [0.7; 0.2];
showDifferencesForGuess(X, y, theta);

pause;
disp('Press enter to try with another guess');
close all;

theta = [0.7; 0.3];
showDifferencesForGuess(X, y, theta);
