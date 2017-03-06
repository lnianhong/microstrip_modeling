function [ err_struct ] = get_errors( cpwmodel )
%errors of each file
%


m = length(cpwmodel);
n = length(cpwmodel(1).files_info);
max_err_RLGC = zeros(m,n,4);
ave_err_RLGC = zeros(m,n,4);
max_err_alpha = zeros(m,n);
ave_err_alpha = zeros(m,n);
max_err_beta = zeros(m,n);
ave_err_beta = zeros(m,n);
max_Z_real = zeros(m,n);
ave_Z_real = zeros(m,n);
max_Z_imag = zeros(m,n);
ave_Z_imag = zeros(m,n);

for ii =1:m
    for jj=1:n
        err_model = cpwmodel(ii).files_info(jj).err_model;
        max_err_RLGC(ii,jj,:) = (err_model.max_err_RLGC)';
        ave_err_RLGC(ii,jj,:) = (err_model.ave_err_RLGC)';
        max_err_alpha(ii,jj)= err_model.max_err_alpha;
        ave_err_alpha(ii,jj) = err_model.ave_err_alpha;
        max_err_beta(ii,jj) = err_model.max_err_beta;
        ave_err_beta(ii,jj) = err_model.ave_err_beta;
        max_Z_real(ii,jj) = err_model.max_Z_real;
        ave_Z_real(ii,jj) = err_model.ave_Z_real;
        max_Z_imag(ii,jj) = err_model.max_Z_imag;
        ave_Z_imag(ii,jj) = err_model.ave_Z_imag;
    end
end



err_struct = struct();
%% ERROR OF RLGC : sim vs model

err_struct.max_err_RLGC = max_err_RLGC;
err_struct.ave_err_RLGC = ave_err_RLGC;

%% error of gamma :sim model

err_struct.max_err_alpha =max_err_alpha;
err_struct.ave_err_alpha = ave_err_alpha;

err_struct.max_err_beta = max_err_beta;
err_struct.ave_err_beta = ave_err_beta;
%% error of Z : sim vs model

err_struct.max_Z_real = max_Z_real;
err_struct.ave_Z_real = ave_Z_real;

err_struct.max_Z_imag = max_Z_imag;
err_struct.ave_Z_imag = ave_Z_imag;

end

