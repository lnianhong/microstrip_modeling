function [ RLGC_fit,RLGC_0123,f_fit ] = RLGC_2_0123( RLGC_sim,freq,f_123_mat)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
    freq_max = 100e9;
    f_2_zone = (4:0.5:25)*1e9;
    f_1 = 1e9*ones(1,length(f_2_zone));%GHz
    f_3 = freq_max*ones(1,length(f_2_zone));
    f_123_mat = [f_1;f_2_zone;f_3];
end
% R_sim = RLGC_sim(:,1);
% L_sim = RLGC_sim(:,2);
% G_sim = RLGC_sim(:,3);
% C_sim = RLGC_sim(:,4);

%% model RL
lambda_RL = [0.5;0.5];
weight_RL = ones(length(freq),2);
weight_RL(100:200,:) = weight_RL(100:200,:)*10;
fun = @(A,B) A./B;
weight_RL = bsxfun(fun,weight_RL,sum(weight_RL,1));
RL_fit_info=fit_RLGC(f_123_mat,freq,RLGC_sim,lambda_RL,weight_RL,'RL',3);
%% model GC
lambda_GC = [0.5;0.5];
weight_GC = ones(length(freq),2);
weight_GC(100:200,:) = weight_GC(100:200,:)*1;
weight_GC = bsxfun(fun,weight_GC,sum(weight_GC,1));
GC_fit_info = fit_RLGC(f_123_mat,freq,RLGC_sim,lambda_GC,weight_GC,'GC',3);

RLGC_fit = [RL_fit_info.Real_fit,RL_fit_info.Imag_fit,...
            GC_fit_info.Real_fit,GC_fit_info.Imag_fit];
RLGC_0123 = [RL_fit_info.Real_0123_fit,RL_fit_info.Imag_0123_fit,...
             GC_fit_info.Real_0123_fit,GC_fit_info.Imag_0123_fit];
f_fit = [RL_fit_info.f_fit,GC_fit_info.f_fit];
end

