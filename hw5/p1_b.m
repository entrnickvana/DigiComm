%
% Baseband PAM Transceiver: 
% This program provide an skeleton for simulation of a baseband pulse
% amplitude modulated (PAM) transmission system.
%
%%%%%%%%%%%%%%%%%%%%%%
%     PARAMETERS     %
%%%%%%%%%%%%%%%%%%%%%%
clear all;
Tb=0.0001;      % Symbol/baud period 
L=100;          % Number of samples per symbol period
Ts=Tb/L;        % Sampling period
alpha=0.5;      % Roll-off factor for the (square-root) raised cosine filters 
N=8*L;          % N+1 is the length of the square-root raised-cosine filter. 
sigma_v=0;      % Standard deviation of channel noise
c=1;            % Channel impulse response
%c=[1; zeros(50,1); 0.8; zeros(148,1);0.5];
%%%%%%%%%%%%%%%%%%%%%%
%       SOURCE       %
%%%%%%%%%%%%%%%%%%%%%%
b=sign(randn(1000,1));

%%%%%%%%%%%%%%%%%%%%%%
%       CODER        %
%%%%%%%%%%%%%%%%%%%%%%
s=b;                        % 2-level PAM
%s=b(1:2:end)+2*b(2:2:end); % 4-level PAM

%%%%%%%%%%%%%%%%%%%%%%
% TRANSMIT FILTERING %
%%%%%%%%%%%%%%%%%%%%%%

t_filt = [-N/2:1:N/2]*Ts;
%pT = rectangularPulse(-Tb/2, Tb/2, t_filt)';
pT = triangularPulse(-Tb, Tb, 2.*t_filt)';
pT = pT/sqrt(pT'*pT);

%plot(t_filt, pT)
%hold on
%plot(t_filt, pT_tri)
%hold off


%pT=sr_cos_p(N,L,alpha);     % Transmit filter: 
%pT=[ones(L,1); 0]; pT=pT/sqrt(pT'*pT);  % P 8(a), Digital Com,
%pT=[0:50 49:-1:0]'; pT=pT/sqrt(pT'*pT);     % P 8(b), Digital Comm
xT=conv(expander(s,L),pT);  % Transmit signal

%%%%%%%%%%%%%%%%%%%%%%
%      CHANNEL       %
%%%%%%%%%%%%%%%%%%%%%%
xR=conv(c,xT);
xR=xR+sigma_v*randn(size(xR)); % Received signal


%%%%%%%%%%%%%%%%%%%%%%
% RECEIVE FILTERING  %
%%%%%%%%%%%%%%%%%%%%%%
pR=pT;    
y=conv(xR,pR);
% plot(y)
%%%%%%%%%%%%%%%%%%%%%%
%      DISPLAY       %
%%%%%%%%%%%%%%%%%%%%%%
%
% Here, the eye-diagram of the received PAM signal is displayed.

%
y=reshape(y,2*L,length(y)/(2*L));   % Reshape the received signal
% vector to columns of duration 2T_b.
y=y(:,8:end-8);     % Delete the transient parts.
t=[0:1/L:2-1/L];    % Time is unit of symbol period.
figure()
axes('position',[0.25 0.25 0.5 0.5])
plot(t,y,'b')
xlabel('t/T_b')


% Nick Elliott analysis on Nyquist Pulse shape and Shaped Symbols

figure()
subplot(2, 1, 1)
plot(t_filt, pT)
xlabel('T_s')
title('Tri Nyquist Pulse')
subplot(2, 1, 2)
plot(xT(1:20*L+1))
xlabel('T_s')
title('Tri Nyquist Pulse Shaped Symbols')

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Timing cost function  %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% y=y(1:floor(length(y)/L)*L);
% y=reshape(y,L,length(y)/L).';
% plot(mean(abs(y).^2))







% for k=1:200
%     plot(t,y(:,k)),pause(0.1)
%     hold on
% end
% 

