function [P, X] = binom1(n, p)

P = zeros(n, 1);
for kk = 0:n
	fact = (factorial(n))/((factorial(kk))*(factorial(n-kk)));
	trial = (p^(kk))*((1-p)^(n-kk));
	P(kk+1) = fact*trial;
end

X = 0:n;

end
