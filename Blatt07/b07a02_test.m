assert(~verLessThan('matlab', '9.1'), 'Your Matlab version is too old. You must use at least R2016b. Please upgrade your Matlab version');

%% Execute the script of the user
set(0, 'DefaultFigureVisible', 'off');  % Do not show any figures during execution of the test script
run('b07a02.m');
set(0, 'DefaultFigureVisible', 'on');
sol = load('solution_vars.mat');

%% Initialization
vecEqual(targets, sol.targets);

%% Network results
vecEqual(errorsFlat, sol.errorsFlat);
vecEqual(errorsDeep, sol.errorsDeep);

%% End
disp('Congratulations! Every test passed.');

%%
function [] = matEqual(matStudent, matSolution)
    tol = 1e-5;
    name = inputname(1);    % Retrieve the variable name of the first vector (student's vector)
    
    % Replace inf and NaN values with 0
    matStudent(~isfinite(matStudent)) = 0;
    matSolution(~isfinite(matSolution)) = 0;
    
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
    
    % Replace inf and NaN values with 0
    vecStudent(~isfinite(vecStudent)) = 0;
    vecSolution(~isfinite(vecSolution)) = 0;
    
    assert(length(vecStudent) == length(vecSolution), sprintf('The number of elements of the vector %s seems to be incorrect. It should contain %d elements but it has only %d elements', name, length(vecSolution), length(vecStudent)));
    assert(all(abs(vecStudent - vecSolution) <= tol), [sprintf('The values in the vector %s are not correct:\nactual = ', name), sprintf(' %f', vecStudent), sprintf('\ntarget = '), sprintf(' %f', vecSolution)]);
end
