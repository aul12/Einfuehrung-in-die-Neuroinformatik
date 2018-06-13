% Initialization
data = [
    1.505648148148148, 9.441774784298829;
    4.4608333333333325, 7.2628223461156365;
    2.871018518518518, 6.082556442099741;
    2.889722222222222, 3.7825510906841497;
    4.6291666666666655, 3.5707084925274506;
    6.705277777777777, 4.629921483310946;
    6.798796296296295, 6.566768095029339;
    7.322499999999999, 2.9957071546735525;
    1.187685185185185, 5.991766757175442;
    2.197685185185185, 7.898350140585734;
    4.142870370370369, 6.112819670407841
];

% Train networks and predict values
netWithout = networkRegression(data(:,1)', data(:,2)', 0);
netWith = networkRegression(data(:,1)', data(:,2)', 0.5);

deltaX = 0.01;
x = 0:deltaX:10;

withoutOutput = netWithout(x);
withOutput = netWith(x);

figure();
scatter(data(:,1), data(:,2));
hold on;
plot(x,withoutOutput);
hold on;
plot(x,withOutput);

xlabel('x');
ylabel('y');
title('Vergleich mit vs. ohne Regularisierung');
legend('Datenpunkte', 'Ohne Regularisierung', 'Mit Regularisierung');
print("b08a02.eps", "-depsc");
