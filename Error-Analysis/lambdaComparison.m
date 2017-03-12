%--------------------------------------------------------%
% Lambda comparison:
%
% We're going to look at how changing the regularisation term 
% affects the ability of our classification model to fit the
% data.
%--------------------------------------------------------%

% Lambda as zero: we don't regularise the model. 
% That means we are not simplifying the hypothesis by 
% reducing the parameters. We expect the performance on the
% training set to be similar to performance on the test set.
% The cost function should decrease over iterations.
lambda = 0;
testError(lambda);
disp('lambda was: ');
disp(lambda);
disp('Press enter to see the next lambda example');
pause;

% Lambda as a mid value: we regularise the model. As we try to 
% minimise the cost function across the training set, theta is 
% penalised as we're making it have a bigger effect on the cost function.
% We expect the model to show bias, so the function wont fit the
% training data or test data very well. The cost function will level
% out fairly quickly.
lambda = 5;
testError(lambda);
disp('lambda was: ');
disp(lambda);
disp('Press enter to see the next lambda example');
pause;

% Lambda as a large value: we regularise the model. As we try to 
% minimise the cost function across the training set, theta is 
% penalised as we're making it have a bigger effect on the cost function.
% We expect the model to show bias, so the function wont fit the
% training data or test data very well. The cost function will level
% out fairly quickly. 
% This will have a bigger effect than the last example, and a high cost
% function.
lambda = 20;
testError(lambda);
disp('lambda was: ');
disp(lambda);

