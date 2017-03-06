function [ cpwmodel_single ] = cpwmodel_err(cpwmodel_single)
%calculate the error of the unit length model
%only the intrinsic was considered
% sim vs table-model or sim vs scalable model:decided by the RLGC0123
%% error of gamma :sim vs fit(unit length)
cpwmodel_single.err_alpha =eval_model(real(cpwmodel_single.gamma_sim),real(cpwmodel_single.gamma_fit),'abs');
cpwmodel_single.max_err_alpha = max(cpwmodel_single.err_alpha);
cpwmodel_single.ave_err_alpha = mean(cpwmodel_single.err_alpha);
cpwmodel_single.err_beta = eval_model(imag(cpwmodel_single.gamma_sim),imag(cpwmodel_single.gamma_fit),'abs');
cpwmodel_single.max_err_beta = max(cpwmodel_single.err_beta);
cpwmodel_single.ave_err_beta = mean(cpwmodel_single.err_beta);

%% error of Z : sim vs fit(unit length)
cpwmodel_single.Z_sim = RLGC_2_Z(cpwmodel_single.RLGC_sim,cpwmodel_single.files_info(1).freq);
cpwmodel_single.Z_fit = RLGC_2_Z(cpwmodel_single.RLGC_fit,cpwmodel_single.files_info(1).freq);

cpwmodel_single.err_Z_real = eval_model(real(cpwmodel_single.Z_sim),real(cpwmodel_single.Z_fit),'abs');
cpwmodel_single.max_Z_real = max(cpwmodel_single.err_Z_real);
cpwmodel_single.ave_Z_real = mean(cpwmodel_single.err_Z_real);
cpwmodel_single.err_Z_imag = eval_model(imag(cpwmodel_single.Z_sim),imag(cpwmodel_single.Z_fit),'abs');
cpwmodel_single.max_Z_imag = max(cpwmodel_single.err_Z_imag);
cpwmodel_single.ave_Z_imag = mean(cpwmodel_single.err_Z_imag);
%% error of RLGC(unit length)
cpwmodel_single.err_RLGC = [eval_model(cpwmodel_single.RLGC_sim(:,1),cpwmodel_single.RLGC_fit(:,1),'abs'),...
                            eval_model(cpwmodel_single.RLGC_sim(:,2),cpwmodel_single.RLGC_fit(:,2),'abs'),...
                            eval_model(cpwmodel_single.RLGC_sim(:,3),cpwmodel_single.RLGC_fit(:,3),'abs'),...
                            eval_model(cpwmodel_single.RLGC_sim(:,4),cpwmodel_single.RLGC_fit(:,4),'abs')];
cpwmodel_single.err_RLGC(1:10,3) = cpwmodel_single.err_RLGC(11,3);% the value of G under low frequency nears zero 
cpwmodel_single.max_err_RLGC = max(cpwmodel_single.err_RLGC);
cpwmodel_single.ave_err_RLGC = mean(cpwmodel_single.err_RLGC);
end