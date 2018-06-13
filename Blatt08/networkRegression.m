function [netRegression] = networkRegression(input, target, lambda)
%networkRegression creates and trains a neural network for a regression task
%   Arguments:
%       - input: one-dimensional input values (first data dimension)
%       - target: one-dimensional target values (second data dimension)
%       - lambda: regularization parameter (set to 0 to disable regularization)
%
%   Returns:
%       - netRegression: the trained network object which can be used directly for prediction
%
    assert(isrow(input), 'The input values must be passed as a row-vector');
    assert(isrow(target), 'The target values must be passed as a row-vector');
    assert(length(input) == length(target), 'Each input value must have an associated target value');
    assert(isscalar(lambda), 'The regularization parameter must be a scalar value');

    rng(1337, 'combRecursive');

    netRegression = fitnet(5);
    netRegression.divideParam.trainRatio = 1;
    netRegression.divideParam.valRatio   = 0;
    netRegression.divideParam.testRatio  = 0;
    netRegression.trainParam.epochs = 50;
    
    netRegression.performParam.regularization = lambda;
    
    netRegression = train(netRegression, input, target);
end
