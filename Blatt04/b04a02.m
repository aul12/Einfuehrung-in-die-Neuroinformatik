%% Initialization
data = [-3 1 -1;
        -3 3 1;
        -2 1 -1;
        -2 4 1;
        -1 3 1;
        -1 4 1;
         2 2 -1;
         2 4 1;
         3 2 -1;
         4 1 -1;];


% Create all vectors
inputs = data(:,1:2);
inputsExtended = [inputs ones(size(inputs,1),1)];
classes = data(:,3);
w = [0,0,0];
       
% Extended weight vectors; each iteration adds one more row
% Since we don't know the exact number of rows in advance, we preallocate the matrix with a maximum size and crop the result in the end
maxVectors = 100;
vectorDimension = 3;
wExtendedMat = zeros(maxVectors, vectorDimension);
L = size(data, 1);
numberOfOptimizations = 1;
wExtendedMat(numberOfOptimizations,:) = w;

changesInLastIteration = 1;
while changesInLastIteration > 0
    changesInLastIteration = 0;
    for c = 1:size(inputs,1)
        currentInput = inputsExtended(c,:);
        desiredClass = classes(c,:);
        calculatedOutput = w * transpose(currentInput);
        
        % Wrong class
        if calculatedOutput <= 0 && desiredClass > 0
            w += currentInput;
        elseif calculatedOutput >= 0 && desiredClass < 0
            w -= currentInput;
        end
        
        % Plot the updated weights
        if calculatedOutput * desiredClass <= 0
            changesInLastIteration += 1;
            numberOfOptimizations += 1;
            wExtendedMat(numberOfOptimizations,:) = w;
            
            x = y = 0;
            if w(2) == 0 
                y = -6:0.1:6;
                x = -w(3)/w(1);
            else
                x = -6:0.1:6;
                y = -(w(1)*x + w(3))/w(2);
            end
            clf();
            plot(x,y);
            hold on;
            scatter(data(:,1), data(:,2), [], data(:,3));
            axis([-6 6 -6 6]);

            while waitforbuttonpress ~= 1
            end
        end
           
    end
end

% Remove unused weight vector entries
wExtendedMat = wExtendedMat(1:numberOfOptimizations, :);