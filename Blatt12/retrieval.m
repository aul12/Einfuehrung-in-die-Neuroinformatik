function [output] = retrieval(input, weights)
%retrieval calculates the network output for an input vector
%   Arguments:
%       - input: the binary vector x
%       - weights: the learned weights of the network
%
%   Returns:
%       - output: the calculated network output y
%
    output = input * weights;
    n = sum(input);
    output(output < n) = 0;
    output(output >= 1) = 1;
end
