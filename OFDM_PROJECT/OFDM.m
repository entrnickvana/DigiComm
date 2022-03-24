
%ECE 5520, Spring 2022
%Project: OFDM TransceiverDue: March 29 (Tuesday)
%In this project, you are guided to develop an OFDM transceiver system.


% 1.  On class canvas you find the pair of MATLAB functions file2bin.m and bin2file.m. Study these two
%     functions and confirm their operation by converting a .txt file (here, call it ‘input.txt’) to binary,
%     and converting the binary bits to a file (here, call it ‘output.txt’). The latter file should have the
%     same content as your original file



% 2. The bit sequence (call it ‘bits’) that you obtain from a .txt file is a vector of zeros and ones.
%    Examine the length of the vector ‘bits’ and if it is not a multiple of 32, extend its length by
%    appending sufficient number of random bits to its end to make its length a multiple of 32. This is
%    related to the fact that we wish to make an OFDM system that transmits 32 bits of data (16 QPSK
%    symbols) in each OFDM symbol. Using the ‘reshape’ function of MATLAB covert the extended
%    bits to a matrix with 32 rows. We will transmit one column of this matrix through each OFDM
%    symbol.


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