load('data.mat');
inputs = data(:,1);
outputs = data(:,2);

netDropout = networkDropout(transpose(inputs), transpose(outputs), 0.1);
netWithoutDropout = networkDropout(transpose(inputs), transpose(outputs), 0.0);

x = -10:0.01:10;
yDropout = predict(netDropout,x);
yWithoutDropout = predict(netWithoutDropout, x);

figure();
plot(x, yDropout);
xlabel("x");
ylabel("y");
hold on;
plot(x, yWithoutDropout);
scatter(inputs, outputs);
legend("Mit Dropout", "Ohne Dropout", "Datenpunkte");

print("b10a01.eps", "-depsc");

save('b10a01_y', 'yDropout');
save('b10a01_net', 'netDropout');