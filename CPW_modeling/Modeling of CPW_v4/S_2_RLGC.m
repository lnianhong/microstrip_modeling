function [R,L,G,C,gamma] = S_2_RLGC(s_params,freq,len,z0)
% convert ths s parameters of CPW into RLGC
% input freq : 1xN
% input s_params: 2x2xN (N is the number of freq)
% Output R, L,G,C
%throws an error if the number of inputs specified in 
%the call to the currently executing function is less than minargs or greater than maxargs.
narginchk(3,4);%
% Check the reference impedance
if nargin < 4
    z0 = 50*ones(length(freq),1);
end

abcd_params = s2abcd(s_params);
% gamma_len11 = acosh(abcd_params(1,1,:));
% gamma_len22 = acosh(abcd_params(2,2,:));
% gamma = (gamma_len11+gamma_len22)/(2*len);

gamma_len = acosh(abcd_params(1,1,:));
gamma = gamma_len/len;
gamma = reshape(gamma,[],1);
% alpha = real(gamma);
% beta = imag(gamma);
s_11 = reshape(s_params(1,1,:),[],1);
s_21 = reshape(s_params(2,1,:),[],1);

Z_square = (z0.^2).*((1+s_11).^2-s_21.^2)./((1-s_11).^2-s_21.^2);
Z = sqrt(Z_square);

R = real(gamma.*Z);
L = imag((gamma.*Z)./(2*pi.*freq));
G = real(gamma./Z);
C = imag((gamma./Z)./(2*pi.*freq));

% if sum(R>=0)~=length(R)
%     error('R is invalid! Negative element exist!')
% end
% if sum(L>=0)~=length(L)
%     error('L is invalid! Negative element exist!')
% end
% if sum(G>=0)~=length(G)
% %     G(G<0) = 1e-4;
%      error('G is invalid! Negative element exist!')
% end
% if sum(C>=0)~=length(C)
% %     C(C<0) = 1e-4;
%      error('C is invalid! Negative element exist!')
% end

end

