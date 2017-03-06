clc;clear;close all;
data_name = '../tmp_data/cpw_2D_W4-10_S3_10';
part_freq_err = 'off';
save_name =[data_name,'_scalable'];
if strcmp(part_freq_err,'on')
    save_name =[save_name,'_freq'];
end
save_name =[save_name,'.mat'];
load(save_name);
cpw_single =  cpw_scalable_2D{1,1};

freq = cpw_single.files_info.freq;
freq_max = 100e9;freq_min = 60e9;
index = freq<=freq_max & freq>=freq_min;
% index = freq >0;

gamma_sim = cpw_single.gamma_sim;
gamma_fit = cpw_single.gamma_fit;

cpwmodel_single.err_alpha =eval_model(real(gamma_sim),real(gamma_fit),'abs');
err_alpha = cpwmodel_single.err_alpha;
max_err_alpha = max(err_alpha(index))
ave_err_alpha = mean(err_alpha(index))