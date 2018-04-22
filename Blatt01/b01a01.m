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
potential = zeros(1,length(timestamps)+1);
potential2 = zeros(1,length(timestamps)+1);

% First neuron
for c = 1:length(timestamps)
    derivative(c) = -potential(c) + input(c);
    potential(c+1) = potential(c) + deltaT * derivative(c);
end

% Second neuron
for c = 1:length(timestamps)
    derivative2(c) = -potential2(c) + 0.8 * potential(c);
    potential2(c+1) = potential2(c) + deltaT * derivative2(c);
end

% Plots
subplot(2,2,1)
plot(timestamps, potential(1:end-1));
title("Dendritischen Potenzial an Neuron 1");
ylabel("t")
xlabel("u_1(t)")

subplot(2,2,3)
plot(timestamps, derivative);
title("Ableitung des dendritischen Potenzial an Neuron 1");
ylabel("t")
xlabel("\dot(u)_1(t)")

subplot(2,2,2)
plot(timestamps, potential2(1:end-1));
title("Dendritischen Potenzial an Neuron 2");
ylabel("t")
xlabel("u_2(t)")

subplot(2,2,4)
plot(timestamps, derivative2);
title("Ableitung des dendritischen Potenzial an Neuron 2");
ylabel("t")
xlabel("\dot(u)_2(t)")

% Save the file to include it in the pdf
print('Plot','-depsc')
