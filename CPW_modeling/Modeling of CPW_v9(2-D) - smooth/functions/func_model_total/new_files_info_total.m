function [ files_info_total ] = new_files_info_total()
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
files_info_total = struct();
files_info_total.name = {};
files_info_total.length = {};
files_info_total.width = {};
files_info_total.space = {};
files_info_total.freq = {};
files_info_total.S = {};
files_info_total.S_fit = {};

files_info_total.num_pi = {};
files_info_total.RLGC_sim = {};
files_info_total.RLGC_fit = {};
files_info_total.RLGC_0123 = {};

files_info_total.Z_sim = {};
files_info_total.Z_fit = {};
files_info_total.gamma_sim = {};
files_info_total.gamma_fit = {};

files_info_total.f_fit = {};
%% error of gamma :sim vs fit(unit length)
files_info_total.err_alpha = {};
files_info_total.max_err_alpha = {};
files_info_total.ave_err_alpha = {};
files_info_total.err_beta = {};
files_info_total.max_err_beta = {};
files_info_total.ave_err_beta = {};
%% error of Z : sim vs fit(unit length)
files_info_total.err_Z_real = {};
files_info_total.max_Z_real = {};
files_info_total.ave_Z_real = {};
files_info_total.err_Z_imag = {};
files_info_total.max_Z_imag = {};
files_info_total.ave_Z_imag = {};
%% error of RLGC: sim vs fit(unit length)
files_info_total.err_RLGC = {};
files_info_total.max_err_RLGC = {};
files_info_total.ave_err_RLGC = {};

end

