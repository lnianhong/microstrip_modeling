function [ err_struct ] = get_errors_unit_length( cpwmodel )
% errors of unit length
err_struct = struct();
%% ERROR OF RLGC : sim vs model

err_struct.max_err_RLGC = reshape([cpwmodel.max_err_RLGC],4,[]);
err_struct.ave_err_RLGC = reshape([cpwmodel.ave_err_RLGC],4,[]);

%% error of gamma :sim model

err_struct.max_err_alpha =[cpwmodel.max_err_alpha];
err_struct.ave_err_alpha = [cpwmodel.ave_err_alpha];

err_struct.max_err_beta = [cpwmodel.max_err_beta];
err_struct.ave_err_beta = [cpwmodel.ave_err_beta];
%% error of Z : sim vs model

err_struct.max_err_Z_real = [cpwmodel.max_err_Z_real];
err_struct.ave_err_Z_real = [cpwmodel.ave_err_Z_real];

err_struct.max_err_Z_imag = [cpwmodel.max_err_Z_imag];
err_struct.ave_err_Z_imag = [cpwmodel.ave_err_Z_imag];

end

