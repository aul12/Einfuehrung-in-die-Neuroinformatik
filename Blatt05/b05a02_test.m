assert(~verLessThan('matlab', '9.1'), 'Your Matlab version is too old. You must use at least R2016b. Please upgrade your Matlab version');

%% Execute the script of the user
set(0, 'DefaultFigureVisible', 'off');  % Do not show any figures during execution of the test script
run('b05a02.m');
set(0, 'DefaultFigureVisible', 'on');
sol = load('solution_vars.mat');

%% Initialization
% Check if the transfer functions are correct by evaluating a few numbers on it
transRange = -3:0.1:3;
vecEqual(trans(transRange), sol.trans(transRange));
vecEqual(transDiff(transRange), sol.transDiff(transRange));

assert(hiddenNeurons == sol.hiddenNeurons, 'The number of hidden neurons you use is different from the exercise description');
assert(learnRate == sol.learnRate, 'The learn rate is different from the exercise description');
assert(epochs == sol.epochs, 'The number of epochs is different from the exercise description');

%% initWeights()
weightsInit = initWeights(sol.inputDimensions, sol.hiddenNeurons, sol.outputDimensions);
assert(ismatrix(weightsInit.w1), 'w1 should be a matrix');
assert(isvector(weightsInit.w2), 'w2 should be a vector');
assert(isvector(weightsInit.theta1), 'theta1 should be a vector');
assert(isscalar(weightsInit.theta2), 'theta2 should be a scalar');

matEqual(weightsInit.w1, sol.weightsInit.w1);
vecEqual(weightsInit.w2, sol.weightsInit.w2);
vecEqual(weightsInit.theta1, sol.weightsInit.theta1);
vecEqual(weightsInit.theta2, sol.weightsInit.theta2);

%% forward()
[y2, u2, y1, u1] = forward(sol.data(:, 1:2), sol.weights, sol.trans);
assert(isvector(y2), 'y2 should be a vector');
assert(isvector(u2), 'u2 should be a vector');
assert(ismatrix(y1), 'y1 should be a matrix');
assert(ismatrix(u1), 'u1 should be a matrix');

vecEqual(y2, sol.y2);
vecEqual(u2, sol.u2);
matEqual(y1, sol.y1);
matEqual(u1, sol.u1);

%% propagateError()
[delta1, delta2] = propagateError(sol.propagateError_T, sol.propagateError_y2, sol.propagateError_w2, sol.propagateError_u1Diff);
assert(isvector(delta1), 'delta1 should be a vector');
assert(isscalar(delta2), 'delta2 should be a scalar');

vecEqual(delta1, sol.delta1);
vecEqual(delta2, sol.delta2);

%% Network result
matEqual(weights.w1, sol.weights.w1);
vecEqual(weights.w2, sol.weights.w2);
vecEqual(weights.theta1, sol.weights.theta1);
vecEqual(weights.theta2, sol.weights.theta2);
vecEqual(errors, sol.errors);

%% End
disp('Congratulations! Every test passed.');

%%
function [] = matEqual(matStudent, matSolution)
    tol = 1e-5;
    name = inputname(1);    % Retrieve the variable name of the first vector (student's vector)
    
    assert(all(size(matStudent) == size(matSolution)), sprintf('The shape of the matrix %s seems to be incorrect. It should be of size %d x %d but it is of size %d x %d', name, size(matSolution, 1), size(matSolution, 2), size(matStudent, 1), size(matStudent, 2)));
    assert(all(all(abs(matStudent - matSolution) <= tol)), [sprintf('The values of the matrix %s are not correct:\nactual:\n', name),...
                                               sprintf([repmat(' %f', 1, size(matStudent, 2)) '\n'], matStudent),...
                                               sprintf('\ntarget:\n'),...
                                               sprintf([repmat(' %f', 1, size(matSolution, 2)) '\n'], matSolution)]);
end

function [] = vecEqual(vecStudent, vecSolution, range)
    % Make sure that both vectors are column-vectors so that the comparison does not fail due to different vector shapes
    if ~iscolumn(vecStudent)
        vecStudent = vecStudent';
    end
    if ~iscolumn(vecSolution)
        vecSolution = vecSolution';
    end

    if exist('range', 'var')
        % Check only a specific range of the vectors
        vecStudent = vecStudent(range);
        vecSolution = vecSolution(range);
    end
    
    tol = 1e-5;
    name = inputname(1);    % Retrieve the variable name of the first vector (student's vector)
    
    assert(length(vecStudent) == length(vecSolution), sprintf('The number of elements of the vector %s seems to be incorrect. It should contain %d elements but it has only %d elements', name, length(vecSolution), length(vecStudent)));
    assert(all(abs(vecStudent - vecSolution) <= tol), [sprintf('The values in the vector %s are not correct:\nactual = ', name), sprintf(' %f', vecStudent), sprintf('\ntarget = '), sprintf(' %f', vecSolution)]);
end
