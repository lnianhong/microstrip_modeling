function [ cpwmodel ] = files_err(cpwmodel)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
num_files = length(cpwmodel.files_info);
for k =1:num_files
    cpwmodel.files_info(k).err_model.err_alpha =eval_model(real(cpwmodel.files_info(k).gamma_i),real(cpwmodel.files_info(k).model_i.gamma_i),'abs');
    cpwmodel.files_info(k).err_model.max_err_alpha = max(cpwmodel.files_info(k).err_model.err_alpha);
    cpwmodel.files_info(k).err_model.ave_err_alpha = mean(cpwmodel.files_info(k).err_model.err_alpha);
    cpwmodel.files_info(k).err_model.err_beta = eval_model(imag(cpwmodel.files_info(k).gamma_i),imag(cpwmodel.files_info(k).model_i.gamma_i),'abs');
    cpwmodel.files_info(k).err_model.max_err_beta = max(cpwmodel.files_info(k).err_model.err_beta);
    cpwmodel.files_info(k).err_model.ave_err_beta = mean(cpwmodel.files_info(k).err_model.err_beta);

    %% error of Z : sim vs fit(unit length)

    cpwmodel.files_info(k).err_model.err_Z_real = eval_model(real(cpwmodel.files_info(k).Z_i),real(cpwmodel.files_info(k).model_i.Z_i),'abs');
    cpwmodel.files_info(k).err_model.max_Z_real = max(cpwmodel.files_info(k).err_model.err_Z_real);
    cpwmodel.files_info(k).err_model.ave_Z_real = mean(cpwmodel.files_info(k).err_model.err_Z_real);
    cpwmodel.files_info(k).err_model.err_Z_imag = eval_model(imag(cpwmodel.files_info(k).Z_i),imag(cpwmodel.files_info(k).model_i.Z_i),'abs');
    cpwmodel.files_info(k).err_model.max_Z_imag = max(cpwmodel.files_info(k).err_model.err_Z_imag);
    cpwmodel.files_info(k).err_model.ave_Z_imag = mean(cpwmodel.files_info(k).err_model.err_Z_imag);

    cpwmodel.files_info(k).err_model.err_RLGC = [eval_model(cpwmodel.files_info(k).RLGC_i(:,1),cpwmodel.files_info(k).model_i.RLGC_i(:,1),'abs'),...
                                eval_model(cpwmodel.files_info(k).RLGC_i(:,2),cpwmodel.files_info(k).model_i.RLGC_i(:,2),'abs'),...
                                eval_model(cpwmodel.files_info(k).RLGC_i(:,3),cpwmodel.files_info(k).model_i.RLGC_i(:,3),'abs'),...
                                eval_model(cpwmodel.files_info(k).RLGC_i(:,4),cpwmodel.files_info(k).model_i.RLGC_i(:,4),'abs')];
    cpwmodel.files_info(k).err_model.max_err_RLGC = max(cpwmodel.files_info(k).err_model.err_RLGC);
    cpwmodel.files_info(k).err_model.ave_err_RLGC = mean(cpwmodel.files_info(k).err_model.err_RLGC);
end
end

