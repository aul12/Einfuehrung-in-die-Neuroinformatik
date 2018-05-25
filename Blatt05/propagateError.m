function [delta1, delta2] = propagateError(T, y2, w2, u1Diff)
%propagateError calculates the error of the network (delta1 and delta2)
%   Arguments:
%       - T: teacher signal
%       - y2: output of the last neuron
%       - w2: weights matrix of the second layer
%       - u1Diff: f'(u1)
%
    delta2 = T-y2;
    delta1 = delta2 * (transpose(w2) .* u1Diff);
end
