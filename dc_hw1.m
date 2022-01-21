%Fs = 1000;            % Sampling frequency                    
%T = 1/Fs;             % Sampling period       
%L = 1500;             % Length of signal
%t = (0:L-1)*T;        % Time vector


% Simulated Continious Signal
dur = 8; 				% 8s signal
Tc = 1e-5; 				% 10us
fsc = 1/Tc;				% 100KHz
L = dur/Tc;				% Number of samples
tc = (-L/2:L/2-1)*Tc; % Time vector

xc = exp(-tc).*heaviside(tc)
%xc = exp(-tc).*heaviside(tc) + cos(2*pi*10*tc);

% Ts = 1s, fs = 1Hz
dur = 8
T_1s = 1;   	        	% Sampling period       
fs_1 = 1/T_1s;   	        % Sampling frequency                    
L = dur/T_1s;           	% Length of signal
t_1s = (-L/2:L/2-1)*T_1s; 	% Time vector

x_1s = exp(-t_1s).*heaviside(t_1s);

% Ts = 100ms, fs = 10Hz
dur = 8
T_100ms = 0.1;   	        		% Sampling period       
fs_10 = 1/T_100ms;  	    		% Sampling frequency                    
L = dur/T_100ms;           			% Length of signal
t_100ms = (-L/2:L/2-1)*T_100ms; 	% Time vector

x_100ms = exp(-t_100ms).*heaviside(t_100ms);

% Ts = 10ms, fs = 100Hz
dur = 8
T_10ms = 0.01;   	        	% Sampling period       
fs_100 = 1/T_10ms;  	    	% Sampling frequency                    
L = dur/T_10ms;           		% Length of signal
t_10ms = (-L/2:L/2-1)*T_10ms; 	% Time vector

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

figure(2)
Xc = fft(xc);
P2c = abs(Xc/L); % Get magnitude, why div by L ?
P1c = P2c(1:L/2+1);
P1c(2:end-1) = 2*P1c(2:end-1);

f = fsc*(0:(L/2))/L;
plot(f, P1c)

%figure(2)
%subplot(4,1,1)
%subplot(4,1,2)
%subplot(4,1,3)
%subplot(4,1,4)
%subplot(4,1,5)
%subplot(4,1,6)
%subplot(4,1,7)
%subplot(4,1,8)











