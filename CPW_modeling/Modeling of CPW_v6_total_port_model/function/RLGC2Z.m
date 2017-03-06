function [ Z] = RLGC2Z(R,L,G,C,freq)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Z = sqrt((R+1i*2*pi*freq.*L)./(G+1i*2*pi*freq.*C));

end

