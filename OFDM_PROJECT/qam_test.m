
b0  = [0 0];
b1  = [0 1];
b2  = [1 0];
b3  = [1 1];
b4  = [0 0];
b5  = [0 0];
b6  = [0 0];
b7  = [0 0];
b8  = [0 0];
b9  = [0 0];
b10 = [0 0];
b11 = [0 0];
b12 = [0 0];
b13 = [0 0];
b14 = [0 0];
b15 = [0 0];
B = [b0  b1  b2  b3  b4  b5  b6  b7  b8  b9  b10 b11 b12 b13 b14 b15]';

symbols = bits2QPSK(B);
figure(1)
subplot(2, 1, 1)
stem(B)
figure(2)
scatter(real(symbols), imag(symbols));

figure(1)
subplot(2,1,2)
bits = QPSK2bits(symbols);
stem(bits)

