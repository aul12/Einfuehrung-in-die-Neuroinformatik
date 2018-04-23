%Constants
tau = 1;
deltaT = 0.1;
tEnd = 30;
weight = 0.8; %c_{12}

timestamps = 0:deltaT:tEnd;
input = zeros(length(timestamps), 1);
input(find(timestamps >= 5 & timestamps <= 15)) = 1;

% Allocate memory
derivative = zeros(1,length(timestamps));
derivative2 = zeros(1,length(timestamps));
potential = zeros(1,length(timestamps));
potential2 = zeros(1,length(timestamps));

% First neuron
for c = 1:length(timestamps)
    derivative(c) = (-potential(c) + input(c))/tau;
    if c ~= length(timestamps)
        potential(c+1) = potential(c) + deltaT * derivative(c);
    end
end

% Second neuron
for c = 1:length(timestamps)
    derivative2(c) = (-potential2(c) + 0.8 * potential(c))/tau;
    if c ~= length(timestamps)
        potential2(c+1) = potential2(c) + deltaT * derivative2(c);
    end
end

% Plots
subplot(2,2,1)
plot(timestamps, potential, "b");
title("Dendritischen Potenzial an Neuron 1");
ylabel("t")
xlabel("u_1(t)")

subplot(2,2,3)
plot(timestamps, derivative, "b");
title("Ableitung des dendritischen Potenzial an Neuron 1");
ylabel("t")
xlabel("u_1'(t)")

subplot(2,2,2)
plot(timestamps, potential2, "g");
title("Dendritischen Potenzial an Neuron 2");
ylabel("t")
xlabel("u_2(t)")

subplot(2,2,4)
plot(timestamps, derivative2, "g");
title("Ableitung des dendritischen Potenzial an Neuron 2");
ylabel("t")
xlabel("u_2'(t)")
