function [X, F] = spec_analysis(x, fs)
N = length(x);
Ts = 1/fs;
[X, F] = freqz(Ts*x, 1, N, 'whole', fs);
F = F - (fs/2);

X = fftshift(abs(X));

t = (0:N-1)*Ts;

subplot(2,1,1), plot(t, x)
xlabel('time (sec)');
ylabel('Amplitude')

subplot(2,1,2), plot(F, X)
xlabel('frequency (Hz)');
ylabel('Magnitude')

end