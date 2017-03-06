function [ S] = RLGC_2_S( RLGC,freq,len,deta_len )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narginchk(3,4);%
% Check the reference impedance
if nargin < 4
    deta_len= 0.01*1e-6;%0.01um
end
num_RLGC_net = len/deta_len;

RLGC_deta = RLGC * deta_len;

R_jwL_deta = RLGC_deta(:,1) + 1i*2*pi*freq.*RLGC_deta(:,2);
G_jwC_deta = RLGC_deta(:,3) + 1i*2*pi*freq.*RLGC_deta(:,4);
ABCD_deta = zeros(2,2,length(freq));
% for k =1:length(freq)
%      ABCD(:,:,k) =[1+R_jwL.*G_jwC,R_jwL;G_jwC,1];
% end
ABCD_deta(1,1,:) =1+R_jwL_deta.*G_jwC_deta;
ABCD_deta(1,2,:) =R_jwL_deta;
ABCD_deta(2,1,:) =G_jwC_deta;
ABCD_deta(2,2,:) =1;
ABCD = zeros(2,2,length(freq));
for ii = 1:length(freq)
    ABCD(:,:,ii) = ABCD_deta(:,:,ii)^num_RLGC_net;
end
S = abcd2s(ABCD);
S(1,1,:) = (S(1,1,:)+S(2,2,:))*0.5;
S(1,2,:) = (S(1,2,:)+S(2,1,:))*0.5;  
S(2,2,:) = S(1,1,:);
S(2,1,:) = S(1,2,:);

end

