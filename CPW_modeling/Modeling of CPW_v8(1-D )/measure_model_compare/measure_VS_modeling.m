clc;clear;close all
dbstop if error;
len = 200;
width = 4;
space = 4;
freq_max = 100e9;
freq_min = 0.5e9;
file_name = sprintf('./S_parameters_measure/Measure_os_L%dW%dS%d.txt',len,width,space);
[s_params_measure,freq_measure] = read_measure_data(file_name);
s_params_measure = s_params_measure(:,:,freq_measure<=freq_max & freq_measure>=freq_min );
freq_measure = freq_measure(freq_measure<=freq_max & freq_measure>=freq_min );

[RLGC_measure,gamma_measure,Z_measure] = S_2_RLGC(s_params_measure,freq_measure,len*1e-6);
load('./tmp_data/cpwmodelw4-12.mat');
s_params_sim =cpwmodel(1).files_info(2).Sparam_i;
freq_sim = cpwmodel(1).files_info(2).freq;
RLGC_sim = cpwmodel(1).files_info(2).RLGC_i;
Z_sim = cpwmodel(1).files_info(2).Z_i;
gamma_sim = cpwmodel(1).files_info(2).gamma_i;
%% plot RLGC
str_title = {'R','L','G','C'};
for k=1:4
    figure
    hold on
    plot(freq_sim,RLGC_sim(:,k),'-r*');
    plot(freq_measure,RLGC_measure(:,k),'-bo');
%     semilogy(freq_sim,RLGC_sim(:,k),freq_measure,RLGC_measure(:,k));
%     semilogy(freq_measure,RLGC_measure(:,k),'-bo');
    legend('em-sim','measure');
    xlabel('freq');
    title(str_title{k});
    hold off
end

%% plot gamma
figure
hold on
plot(freq_sim,real(gamma_sim),'-r*');
plot(freq_measure,real(gamma_measure),'-bo');
legend('em-sim','measure');
xlabel('freq');
title('alpha');
hold off

figure
hold on
plot(freq_sim,imag(gamma_sim),'-r*');
plot(freq_measure,imag(gamma_measure),'-bo');
legend('em-sim','measure');
xlabel('freq');
title('beta');
hold off




% figure
% hold on
% plot(freq_measure,RLGC_measure(:,1),'-bo');
% % legend('em-sim','measure');
% hold off

