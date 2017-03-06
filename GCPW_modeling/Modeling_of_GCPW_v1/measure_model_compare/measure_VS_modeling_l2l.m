clc;clear;close all
dbstop if error;
len = 200;
width = 4;
space = 4;
freq_max = 100e9;
freq_min = 0.5e9;
csv_name = sprintf('../S_parameters_measure/Measure_L200W4S4_gamma_l2l.csv');
freq_alpha_beta = csvread(csv_name,1,0);
freq_measure = freq_alpha_beta(:,1)*1e9;
gamma_measure = (complex(freq_alpha_beta(:,2)*100,freq_alpha_beta(:,3)*100));   

load('../tmp_data/cpwmodelw4-12.mat');
s_params_sim_i =cpwmodel(1).files_info(2).Sparam_i;
freq_sim_i = cpwmodel(1).files_info(2).freq;
RLGC_sim_i = cpwmodel(1).files_info(2).RLGC_i;
Z_sim_i = cpwmodel(1).files_info(2).Z_i;
gamma_sim_i = cpwmodel(1).files_info(2).gamma_i;
%% plot RLGC


%% plot gamma
figure
hold on
plot(freq_sim_i,real(gamma_sim_i),'-r*');
plot(freq_measure,real(gamma_measure),'-bo');
legend('em-sim','measure');
xlabel('freq');
title('alpha');
hold off

figure
hold on
plot(freq_sim_i,imag(gamma_sim_i),'-r*');
plot(freq_measure,imag(gamma_measure),'-bo');
legend('em-sim','measure');
xlabel('freq');
title('beta');
hold off





