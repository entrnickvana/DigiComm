clear all;
close all;	

x = [-3:.1:3-.1];
x_mid = round(length(x)/2) + 1;
x_delta = 5;

b = x_mid + x_delta + 1;
a = x_mid - x_delta;

mask = zeros(1, length(x)); 
mask(a:b-1) = ones(1, b-a);


sigma = 1/sqrt(2);
coeff = 1/(sigma*sqrt(2*pi));
mu = 0;
gauss = coeff*exp(-0.5*((x-mu)./sigma).^2);
m1 = gauss.*mask;
figure()
plot(x, gauss)
hold on
area(x, m1)
hold off

figure()
err = erf(x);
plot(x, err)
hold on

figure();
plot(x, gauss)
hold on
plot(x, err)
hold off

area_erf = erf(.5)
area_norm = sum(gauss(a:b))




