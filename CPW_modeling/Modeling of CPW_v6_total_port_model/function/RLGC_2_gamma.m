function [ gamma ] = RLGC_2_gamma( RLGC,freq)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
gamma = sqrt((RLGC(:,1)+RLGC(:,2).*1i.*2.*pi.*freq).*(RLGC(:,3)+RLGC(:,4).*1i.*2.*pi.*freq));

end

