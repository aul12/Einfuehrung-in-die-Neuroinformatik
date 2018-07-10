%% Load and select data
rng(1337, 'combRecursive');

load('dataChars.mat');

% In this exercise, we use only the first few characters
M = 5;                          % Number of characters
images = images(:, :, 1:M);     % Characters as binary images
imagesVec = imagesVec(1:M, :);  % Characters reshaped to a binary vectors
%imageDim                       % Dimension of the binary images

%% Train the network
weights = trainAssoc(imagesVec);

figure;
for c = 1:M
   retrievedImageVec = retrieval(imagesVec(c,:), weights);
   retrievedImage = reshape(retrievedImageVec, imageDim);
   subplot(2, M*2+1, c);
   imshow(images(:,:,c));
   subplot(2, M*2+1, c+M*2+1);
   imshow(retrievedImage);

   image = imagesVec(c,:);
   image(randperm(length(image), 200)) = 0;
   retrievedImageVec = retrieval(image, weights);
   retrievedImage = reshape(retrievedImageVec, imageDim);
   subplot(2, M*2+1, c+M+1);
   imshow(reshape(image, imageDim));
   subplot(2, M*2+1, c+M*3+2);
   imshow(retrievedImage);
end

print("b12a01.eps", "-depsc");