close all;
clear all;

h1= firpm(20, [0 .2 .35 .5]*2, [0 1 1 0])
H1_mag = abs(fft(h1))

figure(1)
subplot(2, 1, 1)
plot(h1)
subplot(2, 1, 2)
plot(H1_mag)

h2= firpm(30, [0 .2 .35 .5]*2, [0 1 1 0])
H2_mag = abs(fft(h2))

figure(2)
subplot(2, 1, 1)
plot(h2)
subplot(2, 1, 2)
plot(H2_mag)

h3= firpm(50, [0 .2 .35 .5]*2, [0 1 1 0])
H3_mag = abs(fft(h3))

figure(3)
subplot(2, 1, 1)
plot(h3)
subplot(2, 1, 2)
plot(H3_mag)

h4= firpm(100, [0 .2 .35 .5]*2, [0 1 1 0])
H4_mag = abs(fft(h4))

figure(4)
subplot(2, 1, 1)
plot(h4)
subplot(2, 1, 2)
plot(H4_mag)

figure(5)
subplot(4, 2, 1)
plot(h1)
title('Time Domain Filter Band Pass, N=20, fc = .2, .35')
subplot(4, 2, 2)
plot(H1_mag)
title('Magnitude Frequency Response Band Pass, N=20, fc = .2, .35')
subplot(4, 2, 3)
plot(h2)
title('Time Domain Filter Band Pass, N=30, fc = .2, .35')
subplot(4, 2, 4)
plot(H2_mag)
title('Magnitude Frequency Response Band Pass, N=30, fc = .2, .35')
subplot(4, 2, 5)
plot(h3)
title('Time Domain Filter Band Pass, N=50, fc = .2, .35')
subplot(4, 2, 6)
plot(H3_mag)
title('Magnitude Frequency Response Band Pass, N=50, fc = .2, .35')
subplot(4, 2, 7)
plot(h4)
title('Time Domain Filter Band Pass, N=100, fc = .2, .35')
subplot(4, 2, 8)
plot(H4_mag)
title('Magnitude Frequency Response Band Pass, N=100, fc = .2, .35')




