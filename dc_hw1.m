%Fs = 1000;            % Sampling frequency                    
%T = 1/Fs;             % Sampling period       
%L = 1500;             % Length of signal
%t = (0:L-1)*T;        % Time vector


% Simulated Continious Signal
dur = 8; 				% 8s signal
Tc = 1e-5; 				% 10us
fsc = 1/Tc;				% 100KHz
Lc = dur/Tc;				% Number of samples
tc = (-Lc/2:Lc/2-1)*Tc; % Time vector

xc = exp(-tc).*heaviside(tc)
%xc = exp(-tc).*heaviside(tc) + cos(2*pi*10*tc);

% Ts = 1s, fs = 1Hz
dur = 8
T_1s = 1;   	        	% Sampling period       
fs_1 = 1/T_1s;   	        % Sampling frequency                    
L1s = dur/T_1s;           	% Length of signal
t_1s = (-L1s/2:L1s/2-1)*T_1s; 	% Time vector

x_1s = exp(-t_1s).*heaviside(t_1s);

% Ts = 100ms, fs = 10Hz
dur = 8
T_100ms = 0.1;   	        		% Sampling period       
fs_10 = 1/T_100ms;  	    		% Sampling frequency                    
L100ms = dur/T_100ms;           			% Length of signal
t_100ms = (-L100ms/2:L100ms/2-1)*T_100ms; 	% Time vector

x_100ms = exp(-t_100ms).*heaviside(t_100ms);

% Ts = 10ms, fs = 100Hz
dur = 8
T_10ms = 0.01;   	        	% Sampling period       
fs_100 = 1/T_10ms;  	    	% Sampling frequency                    
L10ms = dur/T_10ms;           		% Length of signal
t_10ms = (-L10ms/2:L10ms/2-1)*T_10ms; 	% Time vector

x_10ms = exp(-t_10ms).*heaviside(t_10ms);

figure(1)
subplot(4,1,1)
plot(tc, xc)
xlabel("t simulated continious (@ T_s = 10us, f_s = 100KHz)")
subplot(4,1,2)
stem(t_1s, x_1s)
xlabel("t        (@ T_s = 1s, f_s = 1Hz)")
subplot(4,1,3)
stem(t_100ms, x_100ms)
xlabel("t        (@ T_s = 100ms, f_s = 10Hz)")
subplot(4,1,4)
stem(t_10ms, x_10ms)
xlabel("t        (@ T_s = 10ms, f_s = 100Hz)")

% --- Tc=1e-5 ---
Xc = fft(xc);
P2c = abs(Xc/Lc); % Get magnitude, why div by L ?
P1c = P2c(1:Lc/2+1);
P1c(2:end-1) = 2*P1c(2:end-1);

f = fsc*(0:(Lc/2))/Lc;

% --- Ts=1s ---
X_1s = fft(x_1s);
P2_1s = abs(X_1s/L1s); % Get magnitude, why div by L ?
P1_1s = P2_1s(1:L1s/2+1);
P1_1s(2:end-1) = 2*P1_1s(2:end-1);

f1 = fs_1*(0:(L1s/2))/L1s;


% --- Ts=100ms ---
X_100ms = fft(x_100ms);
P2_100ms = abs(X_100ms/L100ms); % Get magnitude, why div by L ?
P1_100ms = P2_100ms(1:L100ms/2+1);
P1_100ms(2:end-1) = 2*P1_100ms(2:end-1);

f10 = fs_1*(0:(L1s/2))/L1s;



figure(2)
subplot(4,2,1)
plot(tc, xc)
subplot(4,2,2)
plot(f, P1c)
subplot(4,2,3)
stem(t_1s, x_1s)
subplot(4,2,4)
plot(f1, P1_1s)
subplot(4,2,5)
stem(t_100ms, x_100ms)
subplot(4,2,6)
plot(f10, P1_100ms)	
subplot(4,2,7)
subplot(4,2,8)











