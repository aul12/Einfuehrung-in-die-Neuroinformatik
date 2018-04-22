%assert(~verLessThan('matlab', '9.1'), 'Your Matlab version is too old. You must use at least R2016b. Please upgrade your Matlab version');

%% Execute the script of the user
set(0, 'DefaultFigureVisible', 'off');  % Do not show any figures during execution of the test script
run('b01a01.m');
set(0, 'DefaultFigureVisible', 'on');
sol = load('solution_vars.mat');

%% Initialization
assert(tau == sol.tau, '\tau is not set to the correct value');
assert(deltaT == sol.deltaT, '\Delta t is not set to the correct value');
assert(tEnd == sol.tEnd, 't_{end} is not set to the correct value');
assert(weight == sol.weight, 'c_{12} is not set to the correct value');

%% Check vectors
assert(length(input) ~= 30, sprintf('Your input vector has only 30 elements. You are probably confused about the time t and the number of elements in the vector. We need t in the range [0;30] but \\Delta t is not 1, so to store our input values we actually need a larger vector (e.g. of size %d)', sol.input));
assert(length(timestamps) == length(input), 'Your timestamps and input vectors do not have the same length. Note that you need to assign an input value at every timestamp t');

vecEqual(timestamps, sol.timestamps);
vecEqual(input, sol.input);

vecEqual(derivative, sol.derivative, 1:length(derivative)-1); % The last derivative value does not matter and may not be calculated
vecEqual(derivative2, sol.derivative2, 1:length(derivative2)-1);

assert(potential(1) == 0, 'u_1(0) is not set to zero');
vecEqual(potential, sol.potential);
assert(potential2(1) == 0, 'u_2(0) is not set to zero');
vecEqual(potential2, sol.potential2);

%% End
disp('Congratulations! Every test passed.');

%%
function [] = vecEqual(vec1, vec2, range)
    % Make sure that both vectors are column-vectors so that the comparison does not fail due to different vector shapes
    if ~iscolumn(vec1)
        vec1 = vec1';
    end
    if ~iscolumn(vec2)
        vec2 = vec2';
    end

    if exist('range', 'var')
        % Check only a specific range of the vectors
        vec1 = vec1(range);
        vec2 = vec2(range);
    end
    
    tol = 1e-5;
    name = inputname(1);    % Retrieve the variable name of the first vector (student's vector)
    
    assert(length(vec1) == length(vec2), sprintf('The number of elements of the vector %s seems to be incorrect. It should contain %d elements but it has only %d elements', name, length(vec1), length(vec2)));
    assert(all(abs(vec1 - vec2) <= tol), [sprintf('The values in the vector %s are not correct:\nactual = ', name), sprintf(' %f', vec1), sprintf('\ntarget = '), sprintf(' %f', vec2)]);
end
