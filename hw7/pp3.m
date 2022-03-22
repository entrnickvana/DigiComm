close all;

j=i;
N=1024;
alph = 0.25;
L=16;
h = sr_cos_p(N, L, alph);
Tb = 1e-6;
Ts = Tb/L;
F = (1+alph)/Tb;

%h_pad = [h'  zeros(length(h)*3, 1)'];
h_pad = h';
h_pad_hf = floor(length(h_pad)/2)
ts = [0:length(h_pad)-1]*Ts;

h_pad_mod0 = real(h_pad.*exp(j*2*pi*0*F.*ts));
H_mod0 = circshift(abs(fft(h_pad_mod0, 1024)), h_pad_hf);
H_hf = floor(length(H_mod0)/2);
H_mod0_hf = H_mod0(H_hf:-1:1) + H_mod0(H_hf+1:end);

h_pad_mod1 = real(h_pad.*exp(j*2*pi*1*F.*ts));
H_mod1 = circshift(abs(fft(h_pad_mod1, 1024)), h_pad_hf);
H_mod1_hf = H_mod1(H_hf:-1:1) + H_mod1(H_hf+1:end);

h_pad_mod2 = real(h_pad.*exp(j*2*pi*2*F.*ts));
H_mod2 = circshift(abs(fft(h_pad_mod2, 1024)), h_pad_hf);
H_mod2_hf = H_mod2(H_hf:-1:1) + H_mod2(H_hf+1:end);

h_pad_mod3 = real(h_pad.*exp(j*2*pi*3*F.*ts));
H_mod3 = circshift(abs(fft(h_pad_mod3, 1024)), h_pad_hf);
H_mod3_hf = H_mod3(H_hf:-1:1) + H_mod3(H_hf+1:end);

f = [-1*h_pad_hf:h_pad_hf-1]*(1/Ts);
f_hf = [0:h_pad_hf-1]*(1/Ts);
h_agg = h_pad_mod0 + h_pad_mod1 + h_pad_mod2 + h_pad_mod3;

figure()
subplot(5, 2, 1)
plot(ts, h_pad_mod0);

subplot(5, 2, 2)
plot(f, circshift(abs(fft(h_pad_mod0, 1024)), h_pad_hf))

subplot(5, 2, 3)
plot(ts, h_pad_mod1)

subplot(5, 2, 4)
plot(f, circshift(abs(fft(h_pad_mod1, 1024)), h_pad_hf))

subplot(5, 2, 5)
plot(ts, h_pad_mod2)

subplot(5, 2, 6)
plot(f, circshift(abs(fft(h_pad_mod2, 1024)), h_pad_hf))

subplot(5, 2, 7)
plot(ts, h_pad_mod3)

subplot(5, 2, 8)
plot(f, circshift(abs(fft(h_pad_mod3, 1024)), h_pad_hf))

subplot(5, 2, 9)
plot(ts, h_agg)

subplot(5, 2, 10)
plot(f, circshift(abs(fft(h_agg, 1024)), h_pad_hf))

figure()
subplot(5, 2, 1)
plot(ts, h_pad_mod0);

subplot(5, 2, 2)
plot(f_hf, H_mod0_hf)

subplot(5, 2, 3)
plot(ts, h_pad_mod1)

subplot(5, 2, 4)
plot(f_hf, H_mod1_hf)

subplot(5, 2, 5)
plot(ts, h_pad_mod2)

subplot(5, 2, 6)
plot(f_hf, H_mod2_hf)

subplot(5, 2, 7)
plot(ts, h_pad_mod3)

subplot(5, 2, 8)
plot(f_hf, H_mod3_hf)

subplot(5, 2, 9)
plot(ts, h_agg)

subplot(5, 2, 10)
H_agg = circshift(abs(fft(h_agg, 1024)), h_pad_hf);
H_agg_hf = H_agg(H_hf:-1:1) + H_agg(H_hf+1:end)
plot(f_hf, H_agg_hf);


%figure()
%subplot(4, 1, 1)
%plot(h_pad);
%hold on
%plot(h1_pad);
%hold off;
%subplot(3, 1, 2)
%plot(h_pad + h1_pad)
%subplot(3, 1, 3)
%plot(abs(fft(h, 1024)))