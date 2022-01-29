% a)

% Generate vector of pseudorandom values 
% taken from normal distribution
x = randn(1000, 1);

% Creates a figure and plot the original signal and its centered spectrum.
% The original signal is normalized with multiplication Ts*x where fs = 1s.
% The magnitude of the spectrum is centered using fftshift.  't' is
% to intervals Ts of N points.  The spectrum is generated using 'freqz'
% which is described as returning an N-point frequency response of a 
% time domain signal.  F is also normalized by subtracting fs/2 from all
% points in F.

figure(1), spec_analysis(x, 1)

% Create time domain filter using 'fir1'.  Provide parameters for N=30 order
% filter with a cutoff frequency of .2.  This is accomplished by multiplying
% 2*0.2.  

h=fir1(30, 0.2*2)

% x is filtered by a filter constructed from coefficients contained
% in vectors A = [a1, a2, ...] and B = [b1, b2, b3, ...].  This
% filter is a difference equation filter where A coefficients are
% which scale outputs which feedback (I believe adding more that one coefficient
% would construct a IIR filter, which are prone to instability and require memory).
% B coefficients are which scale inputs for an FIR filter.  'h' a vector representing
% the coefficients generated from fir1 to form the FIR filter.

y=filter(h, 1, x)

% Show the filtered time domain output and magnitude of its filtered spectrum
% in frequency domain at fs=1

figure(2), spec_analysis(y, 1)

% b)

% We can see from the code the results of that the input signal which is fairly evenly
% distributed in its frequency spectrum can be filtered using the filter generated
% from B = [h0, h1, ... hN] (h in our case) coefficients generated from 'fir1()' 
% and then used to filter the input x using filter().  Keep in mind, the vector A
% which constitutes IIR taps that scale and feedback y[n-no], in our case A = [1].
% The results show the filtered output.