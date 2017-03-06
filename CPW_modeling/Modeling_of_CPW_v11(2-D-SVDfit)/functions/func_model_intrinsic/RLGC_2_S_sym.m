function [ S] = RLGC_2_S_sym( RLGC,freq,len,deta_len )
% convert the unit length RLGC to real length S parameters
narginchk(3,4);%
% Check the reference impedance
if nargin < 4
    deta_len= 0.01*1e-6;%0.01um
end
num_RLGC_net = len/deta_len;

RLGC_len = RLGC * len;

Z_model_deta = RLGC_len(:,1) + 1i*2*pi*freq.*RLGC_len(:,2);
Y_model_deta = RLGC_len(:,3) + 1i*2*pi*freq.*RLGC_len(:,4);

ABCD = zeros(2,2,length(freq));
for k =1:length(freq)
    ABCD_Y_left_right =   [1,0;Y_model_deta(k)./(2*num_RLGC_net),1];
    ABCD_Y_medium =   [1,0;Y_model_deta(k)./num_RLGC_net,1];
    ABCD_Z = [1, Z_model_deta(k)./(2*num_RLGC_net);0,1];
    ABCD(:,:,k) = ABCD_Y_left_right *ABCD_Z* ...,
                        ((ABCD_Z*ABCD_Y_medium*ABCD_Z)^(num_RLGC_net-1))* ...,
                        ABCD_Z*ABCD_Y_left_right;
end

S = abcd2s(ABCD);
S(1,1,:) = (S(1,1,:)+S(2,2,:))*0.5;
S(1,2,:) = (S(1,2,:)+S(2,1,:))*0.5;  
S(2,2,:) = S(1,1,:);
S(2,1,:) = S(1,2,:);


end

