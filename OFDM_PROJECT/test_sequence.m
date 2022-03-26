


    %                  1010
    %              1110    1011
    %           1111          1001
    %         1101              1000
    %        1100                0000
    %         0100              0001
    %           0101           0011
    %              0111     0010
    %                  0110
    	
d0   =  [0 0 0 0]; % 0
d1   =  [1 0 0 0]; % 1
d2   =  [1 0 0 1]; % 2
d3   =  [1 0 1 1]; % 3
d4   =  [1 0 1 0]; % 4
d5   =  [1 1 1 0]; % 5
d6   =  [1 1 1 1]; % 6
d7   =  [1 1 0 1]; % 7

d8   =  [1 1 0 0]; % 8
d9   =  [0 1 0 0]; % 9
d10  =  [0 1 0 1]; % 10
d11  =  [0 1 1 1]; % 11
d12  =  [0 1 1 0]; % 12
d13  =  [0 0 1 0]; % 13
d14  =  [0 0 1 1]; % 14
d15  =  [0 0 0 1]; % 15

D0_7 = [d0 d1 d2 d3 d4 d5 d6 d7]';
D8_15 = [d8 d9 d10 d11 d12 d13 d14 d15]';

D = [D0_7 D8_15];

symbols0 = bits2QPSK(D0_7);
symbols1 = bits2QPSK(D8_15);

bit0 = QPSK2bits(symbols0);
bit1 = QPSK2bits(symbols1);

