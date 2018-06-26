function [netDropout] = networkDropout(input, target, dropoutRate)
%networkDropout creates and trains a neural network for a regression task
%   Arguments:
%       - input: one-dimensional input values (first data dimension)
%       - target: one-dimensional target values (second data dimension)
%       - dropoutRate: probability for dropping out neurons in the second and third layer
%
%   Returns:
%       - netDropout: the trained network object which can be used directly for prediction
%
    assert(isrow(input), 'The input values must be passed as a row-vector');
    assert(isrow(target), 'The target values must be passed as a row-vector');
    assert(length(input) == length(target), 'Each input value must have an associated target value');
    assert(isscalar(dropoutRate), 'The dropout rate must be a scalar value');
    assert(dropoutRate >= 0 && dropoutRate <= 1, 'The dropout rate must be in the range [0;1]');

    rng(1337, 'combRecursive');
    
    % Define options for training
    options = trainingOptions('adam',...
        'MaxEpochs',3000,...
        'Shuffle','never',...
        'L2Regularization',0.0,...
        'InitialLearnRate',0.01,...
        'GradientDecayFactor',0.999,...
        'ValidationPatience',inf,...
        'Plots','training-progress',...
        'Verbose',false);
    
    layers = [
        sequenceInputLayer(1)
        fullyConnectedLayer(100)
        leakyReluLayer(0.01)
        dropoutLayer(dropoutRate)
        fullyConnectedLayer(100)
        leakyReluLayer(0.01)
        dropoutLayer(dropoutRate)
        fullyConnectedLayer(1)
        regressionLayer()
    ];

    netDropout = trainNetwork(input, target,layers,options);
end
