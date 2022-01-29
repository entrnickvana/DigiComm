close all;
clear all;

a1  = [0.3; 10];
a2  = [0.3; 30];
a3  = [0.4; 10];
a4  = [0.4; 30];
a5  = [0.5; 10];
a6  = [0.5; 30];
a7  = [0.6; 10];
a8  = [0.6; 30];
a9  = [0.7; 10];
a10 = [0.7; 30];

A = [a1 a2 a3 a4 a5 a6 a7 a8 a9 a10];

titles = ["Binomial Distribution (p = 0.3, n= 10)","Binomial Distribution (p = 0.3, n= 30)","Binomial Distribution (p = 0.4, n= 10)","Binomial Distribution (p = 0.4, n= 30)","Binomial Distribution (p = 0.5, n= 10)","Binomial Distribution (p = 0.5, n= 30)","Binomial Distribution (p = 0.6, n= 10)","Binomial Distribution (p = 0.6, n= 30)","Binomial Distribution (p = 0.7, n= 10)","Binomial Distribution (p = 0.7, n= 30)"];

for ii = 1:length(A(1, :))
	[P,X] = binom1(A(2, ii), A(1, ii));
    figure()
	stem(X, P)
	title(sprintf("%s", titles(ii)))
        xlabel('k')
        ylabel('P_k')
end

figure(111)
for ii = 1:length(A(1, :))
	[P,X] = binom1(A(2, ii), A(1, ii));
	plot(X, P)
	hold on
end
xlabel('k')
ylabel('P_k')

hold off

legend('p = 0.3, n = 10','p = 0.3, n = 30','p = 0.4, n = 10','p = 0.4, n = 30','p = 0.5, n = 10','p = 0.5, n = 30','p = 0.6, n = 10','p = 0.6, n = 30','p = 0.7, n = 10','p = 0.7, n = 30')
















