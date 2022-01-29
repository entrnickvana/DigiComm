clear all;

%% P3
awgn = randn(1000, 1)
AWGN = fft(awgn, 1024)
f = 0.2
f1 = fir1(20, f)
F1 = fft(f1)
awgn_filt = conv(f1, awgn)
AWGN_FILT = fft(awgn_filt, 1024)

figure(1)
subplot(2, 1, 1)
plot(awgn)
subplot(2, 1, 2)
plot(abs(AWGN))

figure(2)
subplot(2, 1, 1)
plot(f1)
subplot(2, 1, 2)
plot(abs(F1))

figure(3)
subplot(2, 3, 1)
plot(awgn)
subplot(2, 3, 2)
plot(f1)
subplot(2, 3, 3)
plot(awgn_filt)
subplot(2, 3, 4)
plot(abs(AWGN))
subplot(2, 3, 5)
plot(abs(F1))
subplot(2, 3, 6)
plot(abs(AWGN_FILT))

orders = [20 30 50]
freq1 = [0.2 0.25 0.35]

f1_lo = fir1(20, 0.2*2)
f1_hi = fir1(30, 0.25*2, 'high')
f1_band = fir1(50, [0.2 0.35]*2, 'bandpass')

figure(4)
subplot(3, 2, 1)
plot(f1_lo)
subplot(3, 2, 2)
plot(abs(fft(f1_lo)))
subplot(3, 2, 3)
plot(f1_hi)
subplot(3, 2, 4)
plot(abs(fft(f1_hi)))
subplot(3, 2, 5)
plot(f1_band)
subplot(3, 2, 6)
plot(abs(fft(f1_band)))

figure()
spec_analysis(f1_lo, 1);
title('Low Pass, N = 20, fc = .2')

figure()
spec_analysis(f1_hi, 1);
title('High Pass, N = 30, fc = .25')

figure()
spec_analysis(f1_band, 1);
title('Band Pass, N = 50, fc = .2, .35')

