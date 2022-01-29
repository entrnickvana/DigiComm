close all

%% P1 part a

figure(1)

Tc = .001
fs = 1/Tc

samples = 4*1000
a = 0
b = 1/(2*Tc)
fc = a:(b-a)/samples:b
Xfc = 1./sqrt(1 + 4*pi*pi.*fc.^2)
subplot(2, 1, 1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 1/(2*Tc)])
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
b = (1/(2*Ts))
f = a:(b-a)/samples:b

Xf = 1./sqrt(1 + 4*pi*pi.*f.^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-fs).^2)

figure(111)
plot(f, abs(Xf))
ylabel("|X(f)|")
xlabel("f     @ T_s = 1s, f_s = 1Hz")
return

figure(2)
subplot(3,1,1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 10])
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
title("|X(f)| True Signal vs. Alias Signal")

subplot(3,1,3)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
xlabel("f     @ T_s = 1s, f_s = 1Hz")
ylabel("|X_s(f)| ")
title("|X(f)| Sampled Signal Spectrum")


figure(3)

Ts = 0.1
fs = 1/Ts

samples = 1000
a = 0
b = 1/(2*Ts)
f = a:(b-a)/samples:b


Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)

subplot(3,1,1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 10])
ylim([0 1.5])
title("Simulated Continious |X(f)|")

subplot(3,1,2)
plot(f, Xf)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
hold on
plot(f, Xf1)
legend('True Signal |X(f)|', 'Alias Signal |X(f)|')
xlabel("f     @ T_s = 100ms, f_s = 10z")
ylabel("|X(f)|")
title("|X(f)| True Signal vs. Alias Signal")

subplot(3,1,3)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
xlabel("f     @ T_s = 100ms, f_s = 10Hz")
ylabel("|X_s(f)| ")
title("|X(f)| Alias Comparison")
title("|X(f)| Sampled Signal Spectrum")

figure(4)	

Ts = 0.01
fs = 1/Ts

samples = 1000
a = 0
b = 1/(2*Ts)
f = a:(b-a)/samples:b

Xf = 1./sqrt(1 + 4*pi*pi.*(f-(0*fs)).^2)
Xf1 = 1./sqrt(1 + 4*pi*pi.*(f-(1*fs)).^2)
X_fs = Xf

subplot(3,1,1)
plot(fc, Xfc)
xlabel("f    (simulated continious @ T_s = 1ms, f_s = 1kHz )")
ylabel("|X(f)|")
xlim([0 10])
ylim([0 1.5])
title("Simulated Continious |X(f)|")

subplot(3,1,2)
plot(f, Xf)
hold on
plot(f, Xf1)
legend('True Signal |X(f)|', 'Alias Signal |X(f)|')
xlabel("f     @ T_s = 10ms, f_s = 100Hz")
ylabel("|X(f)|")
xlim([0 1/(2*Ts)])
ylim([0 1.5])
title("|X(f)| True Signal vs. Alias Signal")

subplot(3,1,3)
plot(f, Xf+Xf1)
xlim([0 1/(2*Ts)])
ylim([0 1.5])
xlabel("f     @ T_s = 10ms, f_s = 100Hz")
ylabel("|X_s(f)| ")
title("|X(f)| Sampled Signal Spectrum")

%% Part c

% continious signal x(t) = e^(-t)*u(t)
Tc = 1e-3
tc = (0:8*1024)*Tc
x_tc = exp(-tc).*heaviside(tc)

Ts = 0.01
ts = (0:1024)*Ts
x_ts =  Ts*exp(-ts).*heaviside(ts)

Xf = fft(x_ts, 1024)


figure(5)
subplot(3, 1, 1)
plot(tc, x_tc)
xlabel('t    (Simulated continious, T_s = 1ms)')
ylabel('x(t)')
ylim([0 1.5])

subplot(3, 1, 2)
stem(ts, x_ts)
xlabel('t_s   @ T_s = 10ms')
ylabel('x_s(t)')

subplot(3, 1, 3)
plot(abs(Xf))
ylabel('X_s(f)')
xlabel('f')
xlim([0 1/(2*Ts)])
ylim([0 1.5])
title('Spectrum T_s|X_s(f)|,  N = 1024 Point FFT')

figure(6)
subplot(3, 1, 1)
plot(X_fs)
title('Spectrum of Sampled Time Signal T_s|X_s(f)|')
xlim([0 1/(2*Ts)])
ylim([0 1.5])

subplot(3, 1, 2)
plot(abs(Xf))
title('Specturm of Calculated |X(f)|')
xlim([0 1/(2*Ts)])
ylim([0 1.5])

subplot(3, 1, 3)
plot(X_fs)
hold on
plot(abs(Xf))
title('Comparison of Calculated vs. FFT Computation')
hold off
legend('Calculated Spectrum T_s|X_s(f)|', 'FFT Spectrum |X_s(f)|')
xlim([0 1/(2*Ts)])
ylim([0 1.5])






