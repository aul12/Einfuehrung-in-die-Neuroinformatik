% Aufgabe b
% Generate input data
n = 4;
nInput = 2 * n;
combinations = de2bi(0:2^nInput-1)';

% Each column of both vectors represents an input sequence (this is contrary to the usual convention but Matlabs implementation of neural networks expects the input in this format)
X = combinations(1:n, :);
Y = combinations(n+1:end, :);

T = zeros(1,size(X,2));
for c = 1:size(X,2)
    x = X(:,c);
    y = Y(:,c);
    currentT = mod(transpose(x) * y, 2);
    T(:,c) = currentT;
end

% Aufgabe c
fhidden = 1:2^n+5;
dhidden = 1:n+5;

ferrors = zeros(size(fhidden));
derrors = zeros(size(dhidden));

parfor h = fhidden
    ferrors(h) = trainNetworks(combinations, T, h);
end

parfor h = dhidden
   derrors(h) = trainNetworks(combinations, T, [h h]);
end

figure();
subplot(2,1,1);
plot(fhidden, ferrors);
title('Fehlerfunktion Flat-Network');
xlabel('Anzahl der Neuronen');
ylabel('Minimaler Fehler');

subplot(2,1,2);
plot(derrors);
title('Fehlerfunktion Deep-Network');
xlabel('Anzahl der Neuronen');
ylabel('Minimaler Fehler');

print('b07a02.eps', '-depsc');