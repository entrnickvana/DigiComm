%
% QAM Transceiver: 
% This program provide an skeleton for simulation of a quadratue
% amplitude modulated (QAM) transmission system.
%
%%%%%%%%%%%%%%%%%%%%%%
%     PARAMETERS     %
%%%%%%%%%%%%%%%%%%%%%%
clear all, close all
Tb=0.0001;      % Symbol/baud period 
L=100;          % Number of samples per symbol period
Ts=Tb/L;        % Sampling period
fc=100000;      % Carrier frequency at the transmitter
Dfc=0;      % Carrier frequency offset
phic=0*pi/180;        % Carrier phase offset
alpha=0.5;      % Roll-off factor for the (square-root) raised cosine filters 
K=8;            % Half of the length of the square-root raised cosine filters in Tb. 
sigma_v=0;      % Standard deviation of channel noise
c=1;
%c=[1;zeros(70,1);0.5; zeros(110,1); 0.7];            % Channel impulse response

%%%%%%%%%%%%%%%%%%%%%%
%       SOURCE       %
%%%%%%%%%%%%%%%%%%%%%%
N=1000;
b=sign(randn(N,1));

%%%%%%%%%%%%%%%%%%%%%%
%       CODER        %
%%%%%%%%%%%%%%%%%%%%%%
s=b(1:2:end)+1i*b(2:2:end);    % 4QAM/QPSK

%%%%%%%%%%%%%%%%%%%%%%
% TRANSMIT FILTERING %
%%%%%%%%%%%%%%%%%%%%%%
pT=sr_cos_p(K*L,L,alpha);       % Transmit filter
xbbT=conv(expander(s,L),pT);  % Pulse-shaped transmit signal

%%%%%%%%%%%%%%%%%%%%%%
%     MODULATION     %
%%%%%%%%%%%%%%%%%%%%%%
t=[0:length(xbbT)-1]'*Ts;      % Set the time indices
xT=real(exp(i*2*pi*fc*t).*xbbT);

%%%%%%%%%%%%%%%%%%%%%%
%      CHANNEL       %
%%%%%%%%%%%%%%%%%%%%%%
xR=conv(c,xT);
xR=xR+sigma_v*randn(size(xR)); % Received signal

%%%%%%%%%%%%%%%%%%%%%%
%    DEMODULATION    %
%%%%%%%%%%%%%%%%%%%%%%
t=[0:length(xR)-1]'*Ts;         % Set the time indices
xbbR=2*exp(-i*(2*pi*(fc+Dfc)*t-phic)).*xR;

%%%%%%%%%%%%%%%%%%%%%%
% RECEIVE FILTERING  %
%%%%%%%%%%%%%%%%%%%%%%
pR=pT;    
y=conv(xbbR,pR);
% plot(abs(y(1:end)).^2)

% z=real(y)+1i*[zeros(50,1); imag(y(1:end-50))];
% figure, plot(z)

figure(1),spec_analysis(y.^4,1/Ts)
%%%%%%%%%%%%%%%%%%%%%%
%      DISPLAY       %
%%%%%%%%%%%%%%%%%%%%%%

figure(2),plot(y,'b'),hold on
plot(y(1:L:end),'r*')
axis('square')
xlabel('real part')
ylabel('imaginary part')
axis([-2 2 -2 2])
% % %text(-0.15,-2.2,'(b)')
%pause

%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Timing cost function  %
%%%%%%%%%%%%%%%%%%%%%%%%%%
% y=y(1:floor(length(y)/L)*L);
% y=reshape(y,L,length(y)/L).';
% figure,plot(mean(abs(y).^2))



