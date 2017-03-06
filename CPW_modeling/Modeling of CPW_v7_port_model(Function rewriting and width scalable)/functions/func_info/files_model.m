function [ cpwmodel] = files_model(cpwmodel)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
num_files = length(cpwmodel.files_info);
for k =1:num_files
    cpwmodel.files_info(k).Sparam_i = Z_gamma_2_S( cpwmodel.Z_sim,cpwmodel.gamma_sim,...
                                cpwmodel.files_info(k).freq,cpwmodel.files_info(k).length);
    cpwmodel.files_info(k).RLGC_i = cpwmodel.RLGC_sim;
    cpwmodel.files_info(k).gamma_i = cpwmodel.gamma_sim;
    cpwmodel.files_info(k).Z_i = cpwmodel.Z_sim;
    
    cpwmodel.files_info(k).model_i.net_i = cpwmodel.RLGC_0123;  
    cpwmodel.files_info(k).model_i.Sparam_i = cpw_model_pi_net(cpwmodel.files_info(k).freq,...
                                                cpwmodel.RLGC_0123,cpwmodel.f_fit,...
                                                cpwmodel.files_info(k).length,...
                                                cpwmodel.files_info(k).num_pi);
    [RLGC_i,gamma_i,Z_i] = S_2_RLGC(cpwmodel.files_info(k).model_i.Sparam_i,...
                                    cpwmodel.files_info(k).freq,...
                                    cpwmodel.files_info(k).length);
     cpwmodel.files_info(k).model_i.RLGC_i =RLGC_i;
     cpwmodel.files_info(k).model_i.gamma_i =gamma_i;
     cpwmodel.files_info(k).model_i.Z_i =Z_i;
     
end



end

