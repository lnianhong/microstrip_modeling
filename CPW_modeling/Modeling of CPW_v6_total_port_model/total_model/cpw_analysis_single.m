%不考虑端口效应，单个模型分析
clc;clear;close all
dbstop if error;
addpath('../function')
folder_path = '../S_parameters_sim/length/'; 
files_name = dir('../S_parameters_sim/length/L*_S.csv');
file_name = [folder_path,files_name(4).name];
len =str2double(cell2mat(regexp(file_name,'\d{3}', 'match')));
if isnan(len)
    error('len is nan!')
end
num_pi = ceil(len/12.5);
len = len *1e-6;
freq_min_max = [0.5,100]*1e9;
f_2_zone = (5:0.5:20)*1e9;
f_1 = 1e9*ones(1,length(f_2_zone));%GHz
f_3 = 100e9*ones(1,length(f_2_zone));
f_123_mat = [f_1;f_2_zone;f_3];
lambda = ones(2,2)*0.5;
disp_sw = 'off';
[ RLGC_0123_fit,f_fit_RL,f_fit_GC,Err_RLGC_fit,Err_RLGC_model,Err_s,Err_alpha_beta] ...,
              = cpw_single( file_name,len,freq_min_max,f_123_mat,lambda,num_pi,disp_sw );