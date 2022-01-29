
n = 10;
p = 0.5;
k = 0:n

P = zeros(n, 1);
for kk = k
	fact = (factorial(n))/((factorial(kk))*(factorial(n-kk)));
	trial = (p^(kk))*((1-p)^(n-kk));
	P(kk+1) = fact*trial;
end

plot(k, P)

