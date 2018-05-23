function [y2, u2, y1, u1] = forward(inputX, weights, trans)
%forward calculates the network output
%   Arguments:
%       - inputX: input data organized as samples x dimensions (each row denotes a point)
%       - weights: struct with the parameters w1, w2, theta1 and theta2
%       - trans: activation function f(x) of the hidden layer
%
    u1 = weights.w1 * inputX + weights.theta1;
    y1 = trans(u1);
    u2 = weights.w2 * y1 + weights.theta2;
    y2 = u2;
end
