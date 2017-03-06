function [ S] = Z_gamma_2_S( Z,gamma,freq,len)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ABCD = zeros(2,2,length(freq));
ABCD(1,1,:) =cosh(gamma*len);
ABCD(1,2,:) =Z.*sinh(gamma*len);
ABCD(2,1,:) =sinh(gamma*len)./Z;
ABCD(2,2,:) =ABCD(1,1,:);
S = abcd2s(ABCD);
S(1,1,:) = (S(1,1,:)+S(2,2,:))*0.5;
S(1,2,:) = (S(1,2,:)+S(2,1,:))*0.5;  
S(2,2,:) = S(1,1,:);
S(2,1,:) = S(1,2,:);

end

