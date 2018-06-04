bob = [1/2 1/4 1/8 1/8];
deltaT = 0.01;
t = 0:deltaT:1;

KLdivergences = zeros(size(t));

for c = 1:length(t)
   tmp = C(t(c));
   for x = 1:length(bob)
       KLdivergences(c) = KLdivergences(c) + bob(x) * log2(bob(x)/tmp(x));
   end
end

plot(t, KLdivergences);  
ylabel("D_C(B)");
xlabel("t");
title("Changing the code of Charles to fit to Bob's distribution");
hold on;
plot([2/3 2/3], [0 3]);
legend("KL-Divergence","Minimum");

print("plot.eps", "-depsc");