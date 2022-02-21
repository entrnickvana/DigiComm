%
% SQUARE-ROOT RAISED-COSINE PULSE: h=sr_cos_p(N,L,alpha)
% This function generates a square-root raised-cosine pulse of length N+1. 
% There are L samples per symbol period.
% alpha is the roll-off factor.
%
function brick_filt=brick_wall(N,L)
t=[-N/2:1:N/2]/L;
brick_filt = rectangularPulse(t./Tb)

brick_filt = 0;
end