

function [B] = QPSK2bits(symbols) 
	[symbols_theta, symbols_ro] = cart2pol(real(symbols), imag(symbols));
	B = zeros(8, 4);
for ii = 1:8
    symbols(ii)
    (symbols_theta(ii)/(2*pi))*360
 if     ((symbols_theta(ii) >= 2*pi*(31/32) & symbols_theta(ii) < 2*pi) | (symbols_theta(ii) >= 0 & symbols_theta(ii) < 2*pi*(1/32)));
 	B(ii, :) = [0 0 0 0]';    	
 elseif (symbols_theta(ii) >= 2*pi*((2*1 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*1)/32));     
 	B(ii, :) = [1 0 0 0]';   
 elseif (symbols_theta(ii) >= 2*pi*((2*2 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*2)/32));     
 	B(ii, :) = [1 0 0 1]';    	
 elseif (symbols_theta(ii) >= 2*pi*((2*3 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*3)/32));     
 	B(ii, :) = [1 0 1 1]';    	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*4 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*4)/32));     
 	B(ii, :) = [1 0 1 0]';    	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*5 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*5)/32));     
 	B(ii, :) = [1 1 1 0]';    	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*6 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*6)/32));     
 	B(ii, :) = [1 1 1 1]';    	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*7 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*7)/32));     
 	B(ii, :) = [1 1 0 1]';    	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*8 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*8)/32));     
 	B(ii, :) = [1 1 0 0]';    	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*9 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 +  2*9)/32));     
 	B(ii, :) = [0 1 0 0]';    	 	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*10 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*10)/32));     
 	B(ii, :) = [0 1 0 1]';    	 	 	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*11 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*11)/32));     
 	B(ii, :) = [0 1 1 1]';    	 	 	 	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*12 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*12)/32));     
 	B(ii, :) = [0 1 1 0]';    	 	 	 	 	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*13 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*13)/32));     
 	B(ii, :) = [0 0 1 0]';    	 	 	 	 	 	 	 	 	 	 	 	
 elseif (symbols_theta(ii) >= 2*pi*((2*14 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*14)/32));     
 	B(ii, :) = [0 0 1 1]';    	 	 	 	 	 	 	 	 	 	 	 	 	
 else   (symbols_theta(ii) >= 2*pi*((2*15 - 1)/32) & symbols_theta(ii) < 2*pi*( (1 + 2*15)/32));     
 	B(ii, :) = [0 0 0 1]';    	 	 	 	 	 	 	 	 	 	 	 	 	 	
 end;

end
return


