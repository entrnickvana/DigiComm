
function [S] = bits2QPSK(bits)

%    4 QAM
%	00 --  --  01
%     |    |     |
%     ------------
%     |    |     |
%   10 --   -- 11

	j = i;
	S = zeros(16,1);
	for ii = 1:16
		tmp = binaryVectorToDecimal(bits(2*ii-1:2*ii)');
		switch tmp
			case 0
				S(ii) = -1 + j;
			case 1
				S(ii) =  1 + j;
			case 2
				S(ii) = -1 - j;
			case 3
				S(ii) = 1 - j;
		end
	end

