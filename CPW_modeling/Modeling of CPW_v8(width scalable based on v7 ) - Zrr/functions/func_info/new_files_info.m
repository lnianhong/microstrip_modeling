function [ files_info ] = new_files_info()
%new a struct to include all the useful information 
files_info = struct();
files_info.name = {};
files_info.length = {};
files_info.width = {};
files_info.space = {};
files_info.Sparam_total = {};
files_info.Sparam_i = {}; %instrinsic S
files_info.freq = {};
files_info.RLGC_total = {};
files_info.RLGC_i = {};
files_info.gamma_total = {};
files_info.gamma_i = {};
files_info.Z_total = {};
files_info.Z_i = {};

files_info.len_pi = {};
files_info.num_pi = {};
files_info.model_i = new_model(); %instrinsic S of model
files_info.err_model = new_err_model(); %instrinsic S of model

end

function [model_i] = new_model()%instrinsic model
model_i = struct();
model_i.net_i = {};
model_i.Sparam_i= {};
model_i.RLGC_i = {};
model_i.gamma_i = {};
model_i.Z_i = {};
end

function err_model = new_err_model()%error of instrinsic model
err_model = struct();
%% ERROR OF RLGC : sim vs model
err_model.err_RLGC = {};
err_model.max_err_RLGC = {};
err_model.ave_err_RLGC = {};

%% error of gamma :sim model
err_model.err_alpha = {};
err_model.max_err_alpha = {};
err_model.ave_err_alpha = {};
err_model.err_beta = {};
err_model.max_err_beta = {};
err_model.ave_err_beta = {};
%% error of Z : sim vs model
err_model.err_Z_real = {};
err_model.max_Z_real = {};
err_model.ave_Z_real = {};
err_model.err_Z_imag = {};
err_model.max_Z_imag = {};
err_model.ave_Z_imag = {};
end