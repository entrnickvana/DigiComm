
function [S] = bits2QPSK(bits)
	b1 = binaryVectorToDecimal(bits(1 + 4*0:4 + 4*0)');
	b2 = binaryVectorToDecimal(bits(1 + 4*1:4 + 4*1)');
	b3 = binaryVectorToDecimal(bits(1 + 4*2:4 + 4*2)');
	b4 = binaryVectorToDecimal(bits(1 + 4*3:4 + 4*3)');
	b5 = binaryVectorToDecimal(bits(1 + 4*4:4 + 4*4)');
	b6 = binaryVectorToDecimal(bits(1 + 4*5:4 + 4*5)');
	b7 = binaryVectorToDecimal(bits(1 + 4*6:4 + 4*6)');
	b8 = binaryVectorToDecimal(bits(1 + 4*7:4 + 4*7)');

    %                  1000
    %              1110    1011
    %           1111          1001
    %         1101              1000
    %        1100                0000
    %         0100              0001
    %           0101           0011
    %              0111     0010
    %                  0110

    [s1_r, s1_i] = pol2cart(b1*(2*pi/16), 1);
    [s2_r, s2_i] = pol2cart(b2*(2*pi/16), 1);
    [s3_r, s3_i] = pol2cart(b3*(2*pi/16), 1);
    [s4_r, s4_i] = pol2cart(b4*(2*pi/16), 1);
    [s5_r, s5_i] = pol2cart(b5*(2*pi/16), 1);
    [s6_r, s6_i] = pol2cart(b6*(2*pi/16), 1);
    [s7_r, s7_i] = pol2cart(b7*(2*pi/16), 1);
    [s8_r, s8_i] = pol2cart(b8*(2*pi/16), 1);

    S = [s1_r s2_r s3_r s4_r s5_r s6_r s7_r s8_r] + i*[s1_i s2_i s3_i s4_i s5_i s6_i s7_i s8_i];


return
