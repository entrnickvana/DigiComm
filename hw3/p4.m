clear all;
close all;

%% P4

%% a)

u = 0
sgma = 10
x = 8
x_p = (x-u)/sgma

1-0.5*(erfc(x_p/sqrt(2)))

p4a_result = 1-0.5*(erfc(x_p/sqrt(2)))

%% b)

u = 2
sgma = 2
x = 4

x_p = (x-u)/sgma
p4b_result = .5*(erfc(x_p/sqrt(2)))

%% c)

u = 0
sgma = 5
xb = 6
xa = -2
xp_b = (xb - u)/(sgma)
xp_a = (xa - u)/(sgma)

resultb = 1 - .5*(erfc(xp_b/sqrt(2)))
resulta = 1 - .5*(erfc(xp_a/sqrt(2)))
p4c_result = resultb-resulta

%% d)

u = 2
sgma = 5
xb = 8
xa = 0
xp_b = (xb - u)/(sgma)
xp_a = (xa - u)/(sgma)

resultb = 1 - .5*(erfc(xp_b/sqrt(2)))
resulta = 1 - .5*(erfc(xp_a/sqrt(2)))
p4c_result = resultb-resulta

