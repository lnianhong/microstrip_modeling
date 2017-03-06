function [ cpw_model ] = new_cpwmodel()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cpw_model = struct();
cpw_model.files_info = {};
cpw_model.len = {};
cpw_model.width = {};
cpw_model.space = {};
cpw_model.RLGC_sim = {};
cpw_model.RLGC_f_sim = {};

cpw_model.RLGC_fit = {};
cpw_model.RLGC_0123 = {};

cpw_model.Z_sim = {};
cpw_model.Z_fit = {};
cpw_model.gamma_sim = {};
cpw_model.gamma_fit = {};

cpw_model.f_fit = {};
%% error of gamma :sim vs fit(unit length)
cpw_model.err_alpha = {};
cpw_model.max_err_alpha = {};
cpw_model.ave_err_alpha = {};
cpw_model.err_beta = {};
cpw_model.max_err_beta = {};
cpw_model.ave_err_beta = {};
%% error of Z : sim vs fit(unit length)
cpw_model.err_Z_real = {};
cpw_model.max_Z_real = {};
cpw_model.ave_Z_real = {};
cpw_model.err_Z_imag = {};
cpw_model.max_Z_imag = {};
cpw_model.ave_Z_imag = {};
%% error of RLGC: sim vs fit(unit length)
cpw_model.err_RLGC = {};
cpw_model.max_err_RLGC = {};
cpw_model.ave_err_RLGC = {};

end

