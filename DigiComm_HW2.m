
dur = 12
Tc = 1e-3 % 
fc = 1/Tc
T = 1e3

tc = -dur/2:Tc:dur/2;

% Sampling at T = 1s
Ts_1s = 1;
t_1s = -dur/2:Ts_1s:dur/2;


% Sampling at T = 100ms
Ts_100ms = 0.1;
t_100ms = -dur/2:Ts_100ms:dur/2;


% Sampling at T = 10ms
Ts_10ms = 0.01
t_10ms = -dur/2:Ts_10ms:dur/2;

% --- Signals at different Sampling Frequencies ---
% Simulated continious @ T=1ms
x1 = exp(-tc).*heaviside(tc);
x_1s = exp(-t_1s).*heaviside(t_1s);
x_100ms = exp(-t_100ms).*heaviside(t_100ms);
x_10ms = exp(-t_10ms).*heaviside(t_10ms);


figure(1)
subplot(4, 1, 1)
x1 = exp(-tc).*heaviside(tc);
plot(tc, x1)
xlabel("t (continious)")
ylabel("x(t)")

subplot(4, 1, 2)
x_1s = exp(-t_1s).*heaviside(t_1s);
stem(t_1s, x_1s)
xlabel("t @ Ts = 1s, fs = 1Hz")
ylabel("x(t)")

subplot(4, 1, 3)
x_100ms = exp(-t_100ms).*heaviside(t_100ms);
stem(t_100ms, x_100ms)
xlabel("t @ Ts = 100ms, fs = 10Hz")
ylabel("x(t)")

subplot(4, 1, 4)
x_10ms = exp(-t_10ms).*heaviside(t_10ms);
stem(t_10ms, x_10ms)
xlabel("t @ Ts = 10ms, fs = 100Hz")
ylabel("x(t)")


%X1_mag, X1_phase = fft(x1)
X1 = fft(x1)

figure(2)
subplot(2,1,1)
plot(abs(X1))
subplot(2,1,2)
plot(angle(X1))





