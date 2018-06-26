% Initialization
rng(1337, 'combRecursive');

load('data.mat');
load('b10a01_y.mat');
load('b10a01_net.mat');

x = -10:0.01:10;
W1 = netDropout.Layers(2).Weights;
b1 = netDropout.Layers(2).Bias;
W2 = netDropout.Layers(5).Weights;
b2 = netDropout.Layers(5).Bias;
W3 = netDropout.Layers(8).Weights;
b3 = netDropout.Layers(8).Bias;

p = 0.1;

Y = zeros(1000, size(x,2));

for c=1:1000
   Y1 = leakyRelu(W1 * x + b1);
   for i=1:size(Y1,1)
       Y1(i,randperm(size(Y1,2), round(size(Y1,2)*0.1))) = 0;
   end
   Y2 = leakyRelu(W2 * Y1 + b2);
   for i=1:size(Y2,1)
       Y2(i,randperm(size(Y2,2), round(size(Y2,2)*0.1))) = 0;
   end
   Y3 = W3 * Y2 + b3;
   
   Y(c,:) = Y3;
end

means = mean(Y);
stds = std(Y);

plot(x, yDropout);
hold on;
plot(x, means);
plot(x, means+stds);
plot(x, means-stds);


function y= leakyRelu(x)
    if x>0
        y = x;
    else
        y = 0.01*x;
    end
end