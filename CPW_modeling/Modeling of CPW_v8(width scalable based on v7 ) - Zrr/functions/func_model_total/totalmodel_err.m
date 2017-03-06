function [ totalmodel_single ] = totalmodel_err(totalmodel_single)
%calculate the error of the unit length model
%only the intrinsic was considered
% sim vs table-model or sim vs scalable model:decided by the RLGC0123
%% error of gamma :sim vs fit(unit length)
totalmodel_single.err_alpha =eval_model(real(totalmodel_single.gamma_sim),real(totalmodel_single.gamma_fit),'abs');
totalmodel_single.max_err_alpha = max(totalmodel_single.err_alpha);
totalmodel_single.ave_err_alpha = mean(totalmodel_single.err_alpha);
totalmodel_single.err_beta = eval_model(imag(totalmodel_single.gamma_sim),imag(totalmodel_single.gamma_fit),'abs');
totalmodel_single.max_err_beta = max(totalmodel_single.err_beta);
totalmodel_single.ave_err_beta = mean(totalmodel_single.err_beta);

%% error of Z : sim vs fit(unit length)
totalmodel_single.Z_sim = RLGC_2_Z(totalmodel_single.RLGC_sim,totalmodel_single.freq);
totalmodel_single.Z_fit = RLGC_2_Z(totalmodel_single.RLGC_fit,totalmodel_single.freq);

totalmodel_single.err_Z_real = eval_model(real(totalmodel_single.Z_sim),real(totalmodel_single.Z_fit),'abs');
totalmodel_single.max_Z_real = max(totalmodel_single.err_Z_real);
totalmodel_single.ave_Z_real = mean(totalmodel_single.err_Z_real);
totalmodel_single.err_Z_imag = eval_model(imag(totalmodel_single.Z_sim),imag(totalmodel_single.Z_fit),'abs');
totalmodel_single.max_Z_imag = max(totalmodel_single.err_Z_imag);
totalmodel_single.ave_Z_imag = mean(totalmodel_single.err_Z_imag);
%% error of RLGC(unit length)
totalmodel_single.err_RLGC = [eval_model(totalmodel_single.RLGC_sim(:,1),totalmodel_single.RLGC_fit(:,1),'abs'),...
                            eval_model(totalmodel_single.RLGC_sim(:,2),totalmodel_single.RLGC_fit(:,2),'abs'),...
                            eval_model(totalmodel_single.RLGC_sim(:,3),totalmodel_single.RLGC_fit(:,3),'abs'),...
                            eval_model(totalmodel_single.RLGC_sim(:,4),totalmodel_single.RLGC_fit(:,4),'abs')];
totalmodel_single.max_err_RLGC = max(totalmodel_single.err_RLGC);
totalmodel_single.ave_err_RLGC = mean(totalmodel_single.err_RLGC);
end