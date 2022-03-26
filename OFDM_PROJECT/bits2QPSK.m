    
function [S] = bits2QPSK(bits)
    B = zeros(8, 1);
    S = zeros(8, 1);
	B(1) = binaryVectorToDecimal(bits(1 + 4*0:4 + 4*0));
	B(2) = binaryVectorToDecimal(bits(1 + 4*1:4 + 4*1));	
	B(3) = binaryVectorToDecimal(bits(1 + 4*2:4 + 4*2));
	B(4) = binaryVectorToDecimal(bits(1 + 4*3:4 + 4*3));
	B(5) = binaryVectorToDecimal(bits(1 + 4*4:4 + 4*4));
	B(6) = binaryVectorToDecimal(bits(1 + 4*5:4 + 4*5));
	B(7) = binaryVectorToDecimal(bits(1 + 4*6:4 + 4*6));
	B(8) = binaryVectorToDecimal(bits(1 + 4*7:4 + 4*7));

    %                  1010
    %              1110    1011
    %           1111          1001
    %         1101              1000
    %        1100                0000
    %         0100              0001
    %           0101           0011
    %              0111     0010
    %                  0110
    	

for ii = 1:8
    switch B(ii)
    case 0
      [sr, si] = pol2cart(0*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 8
      [sr, si] = pol2cart(1*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 9
      [sr, si] = pol2cart(2*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 11
      [sr, si] = pol2cart(3*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 10
      [sr, si] = pol2cart(4*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 14
      [sr, si] = pol2cart(5*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 15
      [sr, si] = pol2cart(6*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 13
      [sr, si] = pol2cart(7*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 12
      [sr, si] = pol2cart(8*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 4
      [sr, si] = pol2cart(9*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 5
      [sr, si] = pol2cart(10*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 7
      [sr, si] = pol2cart(11*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 6
      [sr, si] = pol2cart(12*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 2
      [sr, si] = pol2cart(13*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 3
      [sr, si] = pol2cart(14*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
    case 1
      [sr, si] = pol2cart(15*(2*pi/16), 1);    	
      S(ii) = sr + i*si;
     end
 end

return
