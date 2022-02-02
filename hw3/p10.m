close all;


i1 = [1 .5 0 1];
i2 = [1 .5 1 2];
i3 = [1 .5 0 2];
i4 = [1 -.5 0 1];

I = [i1; i2; i3; i4];

j = i;

sgm_s = 1;

Tb = 1e-6;
sps_Tb = 10;
T = Tb/10;
fs = 1/T;

t = -1e-3:Tb/sps_Tb:1e-3;

p = (1/Tb)*rectangularPulse(-0.5, .5, t./Tb);
%c_t1 = circshift([1 zeros(1, length(t) -1)], I(1, 3)*) + circshift([1 zeros(1, length(t) -1)], I(1, 3))

%p2 = p.*conj(p);

f = -(4/Tb):(4/Tb);

Pf = sinc(Tb*f);
Pf2 = Pf.*conj(Pf);

figure(555)
for ii = 1:4
	H1 = I(ii,1) + (I(ii,2)^2)*(exp(j*2*pi.*f*1e-6*(I(ii,4) - I(ii, 3)))  + exp(j*2*pi.*f*1e-6*( I(ii, 3) - I(ii,4) ))) + I(ii,2)^2;
	H = (sgm_s/Tb).*H1.*Pf2;		
	plot(f, H)
	hold on
end

legend('i', 'ii', 'iii', 'iv')

return

%H1 = (sgm_s/Tb).*Pf2.*( I(1, 1)^2 + ((I(1,1)*I(1, 2))^2)*(exp(j*2*pi.*f*(I(1,4) - I(1, 3)))  + exp(j*2*pi.*f*(I(1,3) - I(1, 4)))) + I(1,2)^2);

figure(2)
plot(Ha)

%plot(t, p2);
%spec_analysis(p2, fs);


