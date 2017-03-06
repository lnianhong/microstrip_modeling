function [ s_param_model] = cpw_model_pi_net(freq,R_0123_fit,L_0123_fit,...,
                                             G_0123_fit,C_0123_fit,...,
                                             f_RL,f_GC,...,
                                             cpw_len,num_pi)
% use num_pi sections to model the cpw,the values of the RLGCs come from
% the (L_0123_fit,R_0123_fit,G_123_fit,C_0123_fit) * cpw_len
% output: S parameters of the model.


L_0123_len = L_0123_fit*cpw_len ;% H
R_0123_len = R_0123_fit*cpw_len;% omega
G_0123_len  = G_0123_fit*cpw_len; % s
C_0123_len = C_0123_fit*cpw_len; %F

R_model_len = R_0123_len(1) + R_0123_len(2)* (1-1./(1+(freq./f_RL(1)).^2)) + ...,
    R_0123_len(3)* (1-1./(1+(freq./f_RL(2)).^2)) + ...,
    R_0123_len(4)* (1-1./(1+(freq./f_RL(3)).^2));

L_model_len = L_0123_len(1) + L_0123_len(2)* (1./(1+(freq./f_RL(1)).^2)) + ...,
    L_0123_len(3)* (1./(1+(freq./f_RL(2)).^2)) + ...,
    L_0123_len(4)* (1./(1+(freq./f_RL(3)).^2));

G_model_len =G_0123_len(1) +G_0123_len(2)* (1-1./(1+(freq./f_GC(1)).^2)) + ...,
    G_0123_len(3)* (1-1./(1+(freq./f_GC(2)).^2)) + ...,
    G_0123_len(4)* (1-1./(1+(freq./f_GC(3)).^2));

C_model_len = C_0123_len(1) + C_0123_len(2)* (1./(1+(freq./f_GC(1)).^2)) + ...,
    C_0123_len(3)* (1./(1+(freq./f_GC(2)).^2)) + ...,
    C_0123_len(4)* (1./(1+(freq./f_GC(3)).^2));

Y_model_len = (1i * 2*pi *freq).*C_model_len + G_model_len;
Z_model_len = (1i * 2*pi *freq).*L_model_len + R_model_len;
ABCD_param_model = zeros(2,2,length(freq));
for k =1:length(freq)
    ABCD_Y_left_right =   [1,0;Y_model_len(k)./(2*num_pi),1];
    ABCD_Y_medium =   [1,0;Y_model_len(k)./num_pi,1];
    ABCD_Z = [1, Z_model_len(k)./num_pi;0,1];
    ABCD_param_model(:,:,k) = ABCD_Y_left_right * ...,
                        ((ABCD_Z*ABCD_Y_medium)^(num_pi-1))* ...,
                        ABCD_Z*ABCD_Y_left_right;
%     ABCD_param(:,:,k) = [1,0;Y_model_len(k)./(2*num_pi),1]* ...,
%                         (([1, Z_model_len(k)./num_pi;0,1]*[1,0;Y_model_len(k)./num_pi,1])^(n-1)) * ...,
%                         [1, Z_model_len(k)./num_pi;0,1] * [1,0;Y_model_len(k)./(2*num_pi),1];
end

s_param_model = abcd2s(ABCD_param_model);
s_param_model(1,1,:) = (s_param_model(1,1,:)+s_param_model(2,2,:))*0.5;
s_param_model(1,2,:) = (s_param_model(1,2,:)+s_param_model(2,1,:))*0.5;  
s_param_model(2,2,:) = s_param_model(1,1,:);
s_param_model(2,1,:) = s_param_model(1,2,:);

end

