
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
raw_bits_short = file2bin('short.txt');

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

%% Syncronize
RX = TX;

%% Serialize
sk_rx = [];
for ll = 1:20:length(RX)
	yk_tmp = RX(ll:ll+16-1);
	sk_rx_tmp = fft(yk_tmp, 16);
	sk_rx = [sk_rx sk_rx_tmp];
end

rx_bits = [];
for jj = 1:length(sk_rx(1, :))
	rx_bits_tmp = QPSK2bits(sk_rx(:,jj));
	rx_bits = [rx_bits; rx_bits_tmp];
end

bin2file(rx_bits, 'qam4.txt');


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
