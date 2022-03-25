
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

raw_bits_short = file2bin('input_short.txt');
remainder = mod(length(raw_bits_short), 32)
padding = rand(32 - remainder, 1);
padding(padding <= 0.5) = 0;
padding(padding > 0.5) = 1;
%stem(padding)
raw_bits_mod = [raw_bits_short; padding];
figure()
subplot(2, 1, 1)
stem(raw_bits_short)
subplot(2, 1, 2)
stem(raw_bits_mod)

s_k = reshape(raw_bits_mod, 32, []);

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
figure(666)
for ii = 1:length(s_k(1,:))-1
  S8 = bits2QPSK(s_k(:, ii));
  scatter(real(S8), imag(S8));
  hold on;
end

hold off;


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