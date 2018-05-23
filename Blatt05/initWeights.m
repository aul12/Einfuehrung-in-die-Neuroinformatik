function [weights] = initWeights(inputDimensions, hiddenNeurons, outputDimensions)
%initWeights initializes the weights of the network
%   Arguments:
%       - inputDimensions: number of input neurons
%       - hiddenNeurons: number of hidden neurons
%       - outputDimensyions: number of output neurons
%
%   Returns:
%       - weights: struct with the parameters w1, w2, theta1 and theta2
%
    %rng(1337, 'combRecursive');
    weights.w1 = rand(hiddenNeurons,inputDimensions) .- 0.5;
    weights.w2 = rand(outputDimensions, hiddenNeurons) .- 0.5;
    weights.theta1 = rand(hiddenNeurons,1) .-0.5;
    weights.theta2 = rand(outputDimensions,1) .-0.5;
end
