function [bits] = QPSK2bits(symbols)

%    4 QAM
%	00 --  --  01
%     |    |     |
%     ------------
%     |    |     |
%   10 --   -- 11
    bits = [];
	for ii = 1:length(symbols)
		s_real = real(symbols(ii));
		s_imag = imag(symbols(ii));

		if    (s_real < 0 & s_imag >= 0)
			bits = [bits 0 0];
	    elseif(s_real >= 0 & s_imag >= 0)
			bits = [bits 0 1];	    	
	    elseif(s_real < 0 & s_imag < 0)
			bits = [bits 1 0];	    	
	    elseif(s_real >= 0 & s_imag < 0)
			bits = [bits 1 1];
		end
	end
	bits = bits';
end