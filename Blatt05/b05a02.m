%% Initialization
% Generate data
s = 31;
[x, y, z] = peaks(s);
data = [x(:) y(:) z(:)];
X = data(:, 1:2);
T = data(:, 3);
eta = 0.0001;

train(2,eta,X,T,10,@tanh,@transDiff);

function y = transDiff(x)
    y = ones(size(x))./(cosh(x).^2);
end;
