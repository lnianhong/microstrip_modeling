clc;clear;close all;
freq = (0.5:0.5:4000)*1e9;
omega  = freq*1i;
C= 1e-13;
L= 100e-12;
R1 =50;
R2 = 5;
R3 = 300;
% Z = 50 + (1./(omega.*C).*(R2+omega.*L))./(1./(omega.*C)+(R2+omega.*L));
Z = 50 + (1./(omega.*C+R2).*(R3+omega.*L))./(1./(omega.*C+R2)+(R3+omega.*L));
plot(freq,real(Z))