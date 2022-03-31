clear all;
close all;
rng('default')
j=i;

%% Read File to bit vector
dbg = 1;
demo_on = 1;
SNR = 40;
raw_bits_short = file2bin('input.txt');  % Currently Matthew 5
pilot_seq = file2bin('pilot_sequence.txt'); % Single line 'deadbeef' creating 4 pilots 

%% Calculate padding to make payload divisible by 32
remainder = mod(length(raw_bits_short), 32);
padding = rand(32 - remainder, 1);
padding(padding <= 0.5) = 0;
padding(padding > 0.5) = 1;
raw_bits_mod = [raw_bits_short; padding];

%% SERDES (Serial to Parallel with reshape)
test_bits = reshape(pilot_seq, 32, []); 	% Pilot sequence in bits representing the string 'deadbeef'
bits = reshape(raw_bits_mod, 32, []);   	% Data bits read from file

%% Parallel bits with pilot sequence of 4 pilots at beginning
sk_bits = [test_bits bits];

%% | S/P MAPPING BLOCK |
%% Map each 32 bit vectors to 16 2bit 4QPSK/4QAM symbols 
sk = [];  									% bits mapped to 16 2bit 4QPSK/4QAM symbols 16 x m
test_sk = [];								% Test pilot array
for ii = 1:length(sk_bits(1,:))
	sk_tmp = bits2QPSK(sk_bits(1:32,ii));
	sk = [sk sk_tmp];


	if(ii == 4)
		% Create 4 Pilot Symobls
		test_sk = [test_sk sk(:,1:4)];

		% Debug only
		if(0)
		  figure()
		  subplot(4,1,1)
		  stem(real(test_sk(:,1))); hold on; stem(imag(test_sk(:,1))); hold off;
		  subplot(4,1,2)
		  stem(real(test_sk(:,2))); hold on; stem(imag(test_sk(:,2))); hold off;		
		  subplot(4,1,3)
		  stem(real(test_sk(:,3))); hold on; stem(imag(test_sk(:,3))); hold off;		
		  subplot(4,1,4)
		  stem(real(test_sk(:,4))); hold on; stem(imag(test_sk(:,4))); hold off;				
		end
	end
end

%% | IFFT and ADD CP BLOCK |
%% OFDM IFFT of 16 parallel symobols to a multiplexed TX packet
L=4;
xk = [];
xk_no_cp = [];
for kk = 1:length(sk)
	xk_tmp = ifft(sk(:, kk), 16);
	xk_tmp_cp = [xk_tmp(end-L+1:end); xk_tmp];
	%xk_tmp_cp = [xk_tmp; xk_tmp(end-L:end)];	
	xk_no_cp = [xk_no_cp; xk_tmp];
	xk = [xk; xk_tmp_cp];
end

%% | CHANNEL BLOCK |
%% Add channel noise and rx noise
TX = xk;
	

% channel options
% RX = TX;  % Ideal Channel
RX = conv(TX, [1 -0.5+0.9*j 0.3-0.8*j 0.5+1*j].'); 	% Non-ideal Channel option 1
% RX = conv(TX, [1 -0.5+0.9*j 0.3-0.8*j].'); 	        % Non-ideal Channel option 2
% RX = conv(TX, [1 -0.8].'); 	                        % Non-ideal Channel option 3
% RX = conv(TX, [1 -0.8 0.8*j].'); 	                    % Non-ideal Channel option 4

%% Failing channel options
% RX = conv(TX, [1 -0.8 0.8*j 0.3-0.8*j -0.3+0.9j -0.5].'); % Non-ideal Channel option 5 (Longer than CP, causes failure) 
% RX = conv(TX, [1 -1].'); 	                    			% Non-ideal Channel option 6 (Longer than CP, causes failure)   

% SNR is set at top of file
RX_noise = awgn(RX, SNR); 							    % Receiver and Channel noise in the form of AWGN

%% Plot the effects of AWGN with given SNR value set at top of file
if(dbg == 1 & 0)
  figure()
  plot(real(RX(1:128))); hold on;
  plot(real(RX(1:128) + RX_noise(1:128))); hold off;
  title('Effects of AWGN on real part of RX data');
  legend('RX data', "RX data with AWGN")
end

%% Toggle AWGN to RX
RX = RX + RX_noise;

%% Serialize and FFT
sk_rx = [];
sk_rx_unequalized = [];
equalizer = ones(16,1);

%% | RX CP REMOVAL, EQ, FFT BLOCK |
%% Parallelize loop
for ii = 20:20:length(RX)-20

	% Remove CP
	yk_tmp = RX(ii-19+L:ii);	
	sk_rx_tmp = fft(yk_tmp, 16);

	% Append current received symbol sk_rx
    sk_rx_unequalized = [sk_rx sk_rx_tmp];	
    sk_rx = [sk_rx sk_rx_tmp./equalizer];

    % Calculate Equalizer tap values using channel gain
	if( ii == 20*4) % 20*4 is length of serialized pilot symbols with added CP
		test_sk_rx = sk_rx(:, 1:4);

		% Considered using checks for channel equalization consistency over 4 Pilot Symbols
		% However, boolean comparison has floating point precision issues, just use Pilot 1 for EQ
		eq1 = test_sk_rx(:,1)./test_sk(:,1); % Calc EQ pilot 1
		eq2 = test_sk_rx(:,2)./test_sk(:,2); % Calc EQ pilot 2
		eq3 = test_sk_rx(:,3)./test_sk(:,3); % Calc EQ pilot 3
		eq4 = test_sk_rx(:,4)./test_sk(:,4); % Calc EQ pilot 4

		% Equalize using Pilot Symbol 1
		equalizer = eq1;

		% Plot of rx pilot symobols for debug and analysis
		if(dbg == 1 & 0)
		  figure()
		  subplot(4,1,1)
		  stem(real(test_sk_rx(:,1))); hold on; stem(imag(test_sk_rx(:,1))); hold off;
		  subplot(4,1,2)
		  stem(real(test_sk_rx(:,2))); hold on; stem(imag(test_sk_rx(:,2))); hold off;		
		  subplot(4,1,3)
		  stem(real(test_sk_rx(:,3))); hold on; stem(imag(test_sk_rx(:,3))); hold off;		
		  subplot(4,1,4)
		  stem(real(test_sk_rx(:,4))); hold on; stem(imag(test_sk_rx(:,4))); hold off;				
		end
	end
end

%% Remove 4 Pilot Symbols for equalization from transmission
sk_rx_unequalized = sk_rx_unequalized(:,5:end);
sk_rx = sk_rx(:,5:end);

%% Display Symbols, compare equalized vs. unequalized
if(dbg == 1)
  figure()
  sk_rx_unrolled = reshape(sk_rx, [], 1);
  sk_rx_unrolled_unequalized = reshape(sk_rx_unequalized, [], 1);
  subplot(2,1,1)
  plot(sk_rx_unrolled_unequalized, 'r.');
  axis('square');
  axis([-2 2 -2 2]);
  xlabel('Real')
  ylabel('Imag')  
  title('Unequalized RX data 4QAM constellation')
  subplot(2,1,2)
  plot(sk_rx_unrolled, 'b.');
  xlabel('Real')
  ylabel('Imag')  
  title('Equalized RX data 4QAM constellation')  
  axis([-2 2 -2 2]);
  axis('square');
end

%% Re-map symbols to bits (Serialize)
rx_bits = [];
for jj = 1:length(sk_rx(1, :))
	rx_bits_tmp = QPSK2bits(sk_rx(:,jj));
	rx_bits = [rx_bits; rx_bits_tmp];
end

%% Convert stream of bits to text data
bin2file(rx_bits, 'output.txt');

return

%% Debug Equalizer
eq_coeff = [];
for ii = 1:length(sk_rx(:,1))-10
    eq_tmp = sk_rx(:, ii)./sk(:, ii);
	eq_coeff = [eq_coeff eq_tmp];
	corrected_rx = sk_rx(:, ii)./eq_tmp;

	figure()
	subplot(4,1,1)
	stem(real(sk(:,ii))); hold on; stem(real(sk_rx(:,ii))); hold off;
	legend('real s_k tx', 'real s_k rx');
	subplot(4,1,2)
	stem(imag(sk(:,ii))); hold on; stem(imag(sk_rx(:,ii))); hold off;	
	legend('imag s_k tx', 'imag s_k rx');	
	subplot(4,1,3)
	stem(real(sk(:,ii))); hold on; stem(real(sk_rx(:,ii))); stem(real(corrected_rx)); hold off;	
	legend('real s_k tx', 'real s_k rx', 'real equalized rx');		
	subplot(4,1,4)
	stem(imag(sk(:,ii))); hold on; stem(imag(sk_rx(:,ii))); stem(imag(corrected_rx)); hold off;	
	legend('imag sk tx', 'imag sk rx', 'imag equalized rx');		

end

return

