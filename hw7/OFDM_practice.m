close all;

j=i;
Tb = 1e-3;
Nsamp = 16;
Ts = Tb/Nsamp;
Nsym = 4;
F = 1/Tb;

seed = 1;
r = rng(seed);

s = (2*rand(1, Nsym))-1;
s_sgn = sign(s);
s_up10 = upsample(s_sgn, Nsamp);

figure();
stem(s_up10);

%pt = (1/(sqrt(Tb))).*ones(1, Nsamp);
pt = ones(1, Nsamp);
x = conv(pt,s_up10);
hf_len = floor(length(x)/2);
ts = [0:length(x)-1]*Ts;
%carrier = real(exp(j*2*pi*F.*(ts./Tb)));
carrier = real(exp(j*2*pi*F.*(ts./Tb)));
x_mod = real(x.*exp(j*2*pi*F.*(ts./Tb)));


figure();
subplot(3, 1, 1)
stem(x);
subplot(3, 1, 2)
plot(x_mod)
subplot(3, 1, 3)
plot(carrier)