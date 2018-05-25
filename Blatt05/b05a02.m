%% Initialization
% Generate data
s = 31;
[x, y, z] = peaks(s);
data = [x(:) y(:) z(:)];
X = data(:, 1:2);
T = data(:, 3);
eta = 0.01;

[weights, E] = train(100,eta,X,T,1000,@tanh,@transDiff);

figure();
subplot(2,2,1);
surf(x,y,z);
xlabel("x_1");
ylabel("x_2");
zlabel("peaks(x_1, x_2)");
title("Peaks-Funktion");

subplot(2,2,2);
output = forward(transpose(X),weights,@tanh);
output = reshape(output,size(z));
surf(x,y,output);
xlabel("x_1");
ylabel("x_2");
zlabel("f(x_1, x_2)");
title("Netz-Ausgabe");


subplot(2,2,3);
surf(x,y,abs(output-z));
xlabel("x_1");
ylabel("x_2");
zlabel("|peaks(x_1, x_2) - f(x_1,x_2)|");
title("Differenz der beiden Funktionen");


subplot(2,2,4);
plot(E);
xlabel("i");
ylabel("E(i)");
title("Fehlerverlauf");

print("Plot.eps", "-depsc");