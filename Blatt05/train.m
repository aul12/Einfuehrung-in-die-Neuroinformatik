function [weights, errors] = train(hiddenNeurons, learnRate, inputX, outputT, epochs, trans, transDiff)
%train trains the neural network
%   Arguments:
%       - hiddenNeurons: number of hidden neurons
%       - learnRate: learning rate \eta
%       - inputX: input data organized as samples x dimensions (each row denotes a point)
%       - outputT: teacher signal as column vector
%       - epochs: number of epochs to train the network
%       - trans: transfer function to use in the hidden layer (activation function)
%       - transDiff: derivative of the transfer function
%
    assert(iscolumn(outputT), 'T must be a column vector');
    assert(size(inputX, 1) == size(outputT, 1), 'Each data point must have an associated label');
    rng(1337, 'combRecursive'); % For reproducibility (does also work with parfor: http://de.mathworks.com/help/distcomp/control-random-number-streams.html#btms9o_)
    weights = initWeights(size(inputX,2),hiddenNeurons,size(outputT,2));
    errors = zeros(epochs,1);
    
    for e=1:epochs
        indexSet = randperm(size(inputX,1));
        for c=indexSet
            currentInput = transpose(inputX(c,:));
            trainerOutput = transpose(outputT(c,:));
            [mlpOutput,u2,hiddenOutput,u1] = forward(currentInput, weights,trans);
            [delta1,delta2] = propagateError(trainerOutput,mlpOutput,weights.w2,transDiff(u1));
            
            weights.w1 = weights.w1 + learnRate * (delta1 * transpose(currentInput));
            weights.w2 = weights.w2 + learnRate * delta2 * transpose(hiddenOutput);
            weights.theta1 = weights.theta1 + learnRate * delta1;
            weights.theta2 = weights.theta2 + learnRate * delta2;
        end;

        [mlpOutput,u2,hiddenOutput,u1] = forward(transpose(inputX),weights, trans);
        diff = norm(mlpOutput-transpose(outputT))^2;
        errors(c) = diff;
    end;
end
