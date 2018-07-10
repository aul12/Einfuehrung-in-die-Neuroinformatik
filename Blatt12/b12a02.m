rng(1337, 'combRecursive');

load('dataChars.mat');
permutation = randperm(M);

error = zeros(M, 1);
p = zeros(M,1);

for m=1:M
    currImagesVec = imagesVec(permutation(1:m), :);
    weights = trainAssoc(currImagesVec);
    error(m) = 0;
    for c=1:m
        imageVec = imagesVec(permutation(c), :);
        out = retrieval(imageVec, weights);
        error(m) = error(m) + norm(out - imageVec, 1) / m;
    end
    p(m) = length(find(weights > 0.5)) / length(weights);
end

figure;
subplot(1,2,1);
plot(error);
title("Capacity");
xlabel("m");
ylabel("p_1");
subplot(1,2,2);
plot(p);
title("Error");
xlabel("m");
ylabel("E");

print("b12a02.eps", "-depsc");
