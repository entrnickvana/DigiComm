clear all;
close all;
rng('default')
j=i;

%% Read File to bit vector
dbg = 1;
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


	if(ii == 4 & dbg == 1)
		test_sk = [test_sk sk(:,1:4)];
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
%RX = TX;  % Ideal Channel
RX = conv(TX, [1 -0.5+0.9*j 0.3-0.8*j 0.5+1*j].'); 	% Non-ideal Channel
RX_noise = awgn(RX, SNR); 							% Receiver and Channel noise in the form of AWGN

%% Plot the effects of AWGN with given SNR value set at top of file
if(dbg == 1)
  figure()
  plot(real(RX(1:128))); hold on;
  plot(real(RX(1:128) + RX_noise(1:128))); hold off;
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
		% However, boolean comparison has floating point issues, just use Pilot 1 for EQ
		eq1 = test_sk_rx(:,1)./test_sk(:,1); % Calc EQ pilot 1
		eq2 = test_sk_rx(:,2)./test_sk(:,2); % Calc EQ pilot 2
		eq3 = test_sk_rx(:,3)./test_sk(:,3); % Calc EQ pilot 3
		eq4 = test_sk_rx(:,4)./test_sk(:,4); % Calc EQ pilot 4

		% Equalize using Pilot Symbol 1
		equalizer = eq1;

		% Plot of rx pilot symobols for debug and analysis
		if(dbg == 1)
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
  subplot(2,1,2)
  plot(sk_rx_unrolled, 'b.');
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
bin2file(rx_bits, 'pilot_test2.txt');

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
	legend('real sk tx', 'real sk rx');
	subplot(4,1,2)
	stem(imag(sk(:,ii))); hold on; stem(imag(sk_rx(:,ii))); hold off;	
	legend('imag sk tx', 'imag sk rx');	
	subplot(4,1,3)
	stem(real(sk(:,ii))); hold on; stem(real(sk_rx(:,ii))); stem(real(corrected_rx)); hold off;	
	legend('real sk tx', 'real sk rx', 'real corrected rx');		
	subplot(4,1,4)
	stem(imag(sk(:,ii))); hold on; stem(imag(sk_rx(:,ii))); stem(imag(corrected_rx)); hold off;	
	legend('imag sk tx', 'imag sk rx', 'imag corrected rx');		

end

return

eq1 = sk_rx_tmp./sk_tmp;
sk_rx_corrected = sk_rx_tmp./eq1;

subplot(4, 1, 1)
stem(real(sk_tmp));
hold on;
stem(real(sk_rx_tmp));
legend('real tx', 'real rx')
hold off;
subplot(4, 1, 2)
stem(imag(sk_tmp));
hold on;
stem(imag(sk_rx_tmp));
legend('imag tx', 'imag rx')
hold off;
subplot(4, 1, 3)
stem(real(sk_tmp));
hold on;
stem(real(sk_rx_corrected));
legend('real tx', 'real corrected rx')
hold off;
legend('real rx', 'real eq rx')
subplot(4, 1, 4)
stem(imag(sk_tmp));
hold on;
stem(imag(sk_rx_corrected));
legend('imag tx', 'imag corrected rx')
hold off;







%figure(123)
%subplot(4, 2, 1)
%stem(real(xk_tmp));
%title('x real')
%subplot(4, 2, 2)
%stem(imag(xk_tmp));
%title('x imag')
%subplot(4, 2, 3)
%stem(real(yk_tmp));
%title('y real')
%subplot(4, 2, 4)
%stem(imag(yk_tmp));
%title('y imag')
%subplot(4, 2, 5)
%stem(real_eq);
%hold on;
%stem(imag_eq);
%legend('real eq', 'imag eq');
%hold off;
%subplot(4, 2, 6)
%stem(real(yk_tmp));
%hold on;
%stem(real(eq_result));
%legend('y real', 'eq real result')
%hold off;
%subplot(4, 2, 7)
%stem(imag(yk_tmp));
%hold on;
%stem(imag(eq_result));
%legend('y imag', 'eq imag result')
%hold off;
%subplot(4, 2, 8)
%stem(real(xk_tmp));
%hold on;
%stem(real(eq_result));
%legend('y real', 'x real result')
%hold off;




% 3. Develop a MATLAB function that take a column of 32 bits, and covert them to a column of
%    16 QPSK symbols, using a gray coding of your choice. Call it bits2QPSK.m Also, develop the
%    counterpart of bits2QPSK.m to convert symbols back to bits. Call it QPSK2bits.m.
%    Examine the codes that you have written so far to make sure everything works as planned. Your
%    test procedure should examine the following steps in sequence:
%    file2bin(...)
%    reshape the vector ‘bits’
%    convert bits to QPSK symbols
%    convert QPSK symbols to bits
%    convert the matrix of bits to a column vector
%    bin2file(...)


% 4. Following Figure 6.7 of the class text, by calling/using the above functions/codes, develop a program
%    for an OFDM transceiver (transmitter plus receiver) with IFFT/FFT length 16 and CP length 4.
%    Assuming an ideal channel, examine the correct functionality of your codes.

% 5. By introducing a channel with impulse response c = [1 −0.5+0.9j 0.3−0.8j 0.5+1j], examine the
%    result of your code. Expectedly, it is not going to work! You need a set of single tap equalizers to
%    compensate the distortion introduced by the channel. One way of finding the equalizers coefficients
%    is to transmit a known OFDM symbol (16 QPSK symbols) at the beginning of transmission and
%    set the equalizers coefficients so that the known OFDM symbol appears after equalizers. Using an
%    arbitrary OFDM symbol of your choice modify your code to be able to transmit data through any
%    arbitrary channel of a length smaller than or equal to the CP length.


% 6. Examine the functionality of your code by adding channel noise and a few random choices of the
%    channel impulse response.


% Note: Since the transmission is through an equivalent baseband channel, all signals, including channel
% noise and impulse response are, in general, complex-valued.
% Report: Summarize your finding in a report, consisting an abstract of 100 words or less, an introduction
% explaining how OFDM works (think of teaching one of your peers), two or three sections explaining your
% codes, and a conclusion of 100 words or less. The total length of your report should be limited to 3
% pages of double space text and as many figures as you wish. Keep text and figures in separate
% pages. Submit a pdf copy of your report along with your MATLAB codes all in a zip file with the name
% DigCom2022Project(your name).zip. Upload on canvas.
