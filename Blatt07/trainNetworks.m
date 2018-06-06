function [bestError] = trainNetworks(combinations, targets, hidden)
%trainNetworks trains the network multiple times and returns the best result
%   Arguments:
%       - combinations: input data organized as features x observations (each column defines a data point). This is the required format for Matlabs train() function
%       - targets: label for each data point (as defined by the binary dot product function)
%       - hidden: number of hidden neurons to use per layer (as vector if multiple hidden layers should be used)
%
%   Return value:
%       - bestError: the value for the best error (MSE) over all trained networks
%
    assert(isrow(targets), 'targets should be a row vector');
    assert(isscalar(hidden) || isrow(hidden), 'hidden should either be a scalar value (number of hidden neurons in the flat hierarchy) or a vector defining the number of hidden neurons per layer');

    rng(1337, 'combRecursive');
    
    minError = 100000;
    for c = 1:20
        net = fitnet(hidden);
        net.divideParam.trainRatio = 1;
        net.divideParam.valRatio   = 0;
        net.divideParam.testRatio  = 0;
        net.trainParam.epochs = 300;
        net = train(net, combinations, targets);
        
        error = perform(net, net(combinations), targets);
        if error < minError
            minError = error;
        end
    end
    
    bestError = minError;
end
