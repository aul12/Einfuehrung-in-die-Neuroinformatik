function [weights] = trainAssoc(imagesVec)
%trainAssoc stores examples in a neural associative memory using the Hebb rule
%   Argument:
%       - imagesVec: the examples to store as a M x length matrix (each character binary vector is stored in a row)
%
%   Returns:
%       - weights: learned weight matrix of the network
%
    weights = zeros(size(imagesVec,2));
    for mu = 1:size(imagesVec,1)
       weights = weights | (transpose(imagesVec(mu,:)) * imagesVec(mu,:));   
    end
end
