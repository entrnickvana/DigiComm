close all


Ts = 1
fs = 1/Ts

samples = 256
a = 0
b = 1/(2*Ts)
f = a:1/samples:b

Xf = 1./sqrt(1 + 4*pi*pi.*f.^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-100).^2)

figure(1)
subplot(2,1,1)
plot(f, Xf)
hold on
plot(f, Xf1)
subplot(2,1,2)
plot(f, Xf+Xf1)



Ts = 0.1
fs = 1/Ts

samples = 256
a = 0
b = 1/(2*Ts)
f = a:1/samples:b


Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)

figure(2)
subplot(2,1,1)
plot(f, Xf)
hold on
plot(f, Xf1)
subplot(2,1,2)
plot(f, Xf+Xf1)
	

Ts = 0.01
fs = 1/Ts

samples = 256
a = 0
b = 1/(2*Ts)
f = a:1/samples:b

f = fs*(-samples/2:samples/2 -1)


Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)

figure(3)
subplot(2,1,1)
plot(f, Xf)
hold on
plot(f, Xf1)
subplot(2,1,2)
plot(f, Xf+Xf1)
