%assert(~verLessThan('matlab', '9.1'), 'Your Matlab version is too old. You must use at least R2016b. Please upgrade your Matlab version');

%% Execute the script of the user
set(0, 'DefaultFigureVisible', 'off');  % Do not show any figures during execution of the test script
waitforbuttonpress = 1; % This is a bit hacky and in general not a good idea but it allows the test script to execute the script without the need for the user to press any key
run('b04a02.m');
clear waitforbuttonpress
set(0, 'DefaultFigureVisible', 'on');
sol = load('solution_vars.mat');

%% Perceptron Algorithm
assert(L == 0, 'The perceptron learning algorithm must run until L = 0');

assert(all(size(wExtendedMat) == size(sol.wExtendedMat)),...
       sprintf('The shape of the matrix wExtendedMat seems to be incorrect. It should be of size %d x %d but it is of size %d x %d', size(sol.wExtendedMat, 1), size(sol.wExtendedMat, 2), size(wExtendedMat, 1), size(wExtendedMat, 2)));

% Check each row individually
for row = 1:size(wExtendedMat, 1)
    vecEqual(wExtendedMat(row, :), sol.wExtendedMat(row, :))
end

matEqual(wExtendedMat, sol.wExtendedMat);

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
