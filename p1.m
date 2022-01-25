close all

%% P1 part a

figure(1)

Ts = .001
fs = 1/Ts

samples = 4*1000
a = 0
b = 1/(2*Ts)
fc = a:(b-a)/samples:b
Xfc = 1./sqrt(1 + 4*pi*pi.*fc.^2)
subplot(2, 1, 1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 1/(2*Ts)])
ylim([0 1.5])
title("Simulated Continious |X(f)|")

subplot(2, 1, 2)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 10])
ylim([0 1.5])
title("Simulated Continious |X(f)| (zoomed in)")


Ts = 1
fs = 1/Ts

samples = 1000
a = 0
b = 1/(2*Ts)
f = a:(b-a)/samples:b

Xf = 1./sqrt(1 + 4*pi*pi.*f.^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-fs).^2)

figure(2)
subplot(3,1,1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")

xlim([0 1/(2*Ts)])
ylim([0 1.5])
title("Simulated Continious |X(f)|")


subplot(3,1,2)
plot(f, Xf)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
hold on
plot(f, Xf1)
legend('True Signal |X(f)|', 'Alias Signal |X(f)|')
xlabel("f     @ T_s = 1s, f_s = 1Hz")
ylabel("|X(f)|")

subplot(3,1,3)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
xlabel("f     @ T_s = 1s, f_s = 1Hz")
ylabel("|X_s(f)| ")


return

Ts = 0.1
fs = 1/Ts

samples = 1000
a = 0
b = 1/(2*Ts)
f = a:(b-a)/samples:b


Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)

figure(2)
subplot(2,1,1)
plot(f, Xf)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
hold on
plot(f, Xf1)
subplot(2,1,2)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])

	

Ts = 0.01
fs = 1/Ts

samples = 1000
a = 0
b = 1/(2*Ts)
f = a:(b-a)/samples:b

Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)

figure(3)
subplot(2,1,1)
plot(f, Xf)
hold on
plot(f, Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
subplot(2,1,2)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])

