
%ECE 5520, Spring 2022
%Project: OFDM TransceiverDue: March 29 (Tuesday)
%In this project, you are guided to develop an OFDM transceiver system.

%function [padded_data] = gen_padding(data)
%	remainder = mod(length(data), 32);
%	padding = rand(32 - remainder, 1);
%	padding(padding >= 0.5) = 1;
%	padding(padding < 0.5) = 0;	
%	padded_data = [data; padde_data];
%return
close all;
rng('default')

j=i;

% 1.  On class canvas you find the pair of MATLAB functions file2bin.m and bin2file.m. Study these two
%     functions and confirm their operation by converting a .txt file (here, call it ‘input.txt’) to binary,
%     and converting the binary bits to a file (here, call it ‘output.txt’). The latter file should have the
%     same content as your original file


%raw_bits = file2bin('input.txt');
%%stem(raw_bits);
%bin2file(raw_bits, 'output.txt');


% 2. The bit sequence (call it ‘bits’) that you obtain from a .txt file is a vector of zeros and ones.
%    Examine the length of the vector ‘bits’ and if it is not a multiple of 32, extend its length by
%    appending sufficient number of random bits to its end to make its length a multiple of 32. This is
%    related to the fact that we wish to make an OFDM system that transmits 32 bits of data (16 QPSK
%    symbols) in each OFDM symbol. Using the ‘reshape’ function of MATLAB covert the extended
%    bits to a matrix with 32 rows. We will transmit one column of this matrix th2ough each OFDM
%    symbol.


%% Read File to bit vector

raw_bits_short = file2bin('input.txt');

%% Calculate padding
remainder = mod(length(raw_bits_short), 32)
padding = rand(32 - remainder, 1);
padding(padding <= 0.5) = 0;
padding(padding > 0.5) = 1;
%stem(padding)
raw_bits_mod = [raw_bits_short; padding];

%% Show row input bits for debug
%figure()
%subplot(2, 1, 1)
%stem(raw_bits_short)
%subplot(2, 1, 2)
%stem(raw_bits_mod)

%% SERDES (Serial to Parallel with reshape)
sk_bits = reshape(raw_bits_mod, 32, []);

%% Map 32 bit vectors to 16 4bit QPSK/QAM symbols
sk = [];
for ii = 1:length(sk_bits(1,:))
	sk_tmp = bits2QPSK(sk_bits(1:32,ii));
	sk = [sk sk_tmp];
end

%% Symbol Debug
%figure(1)
%scatter(real(sk), imag(sk));

%% OFDM IFFT of 16 parallel symobols to a multiplexed TX packet
L=4-1;
xk = [];
xk_no_cp = [];
for kk = 1:length(sk)
	xk_tmp = ifft(sk(:, kk), 16);
	xk_tmp_cp = [xk_tmp; xk_tmp(end-L:end)];
	xk_no_cp = [xk_no_cp; xk_tmp];
	xk = [xk; xk_tmp_cp];
end


%% Add channel effects
TX = xk;

%% Add channel noise and rx noise
%RX = TX;
RX = conv(TX, [1 -0.5+0.9*j 0.3-0.8*j 0.5+1*j]');
eq_coeff = load('coeff.mat');
eq_c = eq_coeff.out;

%% Serialize and FFT
sk_rx = [];
for ll = 20:20:length(RX)-20
	yk_tmp_cp = RX(ll-19:ll);	
	yk_tmp = RX(ll-19:ll-4);
	sk_rx_tmp = fft(yk_tmp, 16);
	sk_rx_tmp_corrected = sk_rx_tmp./eq_c;
	%sk_rx = [sk_rx sk_rx_tmp];	
	sk_rx = [sk_rx sk_rx_tmp_corrected];
end

%% Reserialize
rx_bits = [];
for jj = 1:length(sk_rx(1, :))
	rx_bits_tmp = QPSK2bits(sk_rx(:,jj));
	rx_bits = [rx_bits; rx_bits_tmp];
end

bin2file(rx_bits, 'qam4_channel_test.txt');

eq1 = sk_rx_tmp./sk_tmp;
sk_rx_corrected = sk_rx_tmp./eq1;
out = eq1;
save('coeff.mat', 'out');

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



%bin2file(out_bits, 'crazy_output.txt');


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
