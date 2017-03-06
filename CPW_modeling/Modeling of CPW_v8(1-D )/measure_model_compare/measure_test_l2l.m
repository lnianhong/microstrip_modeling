clc;clear;close all
dbstop if error;
len = 200;
width = 4;
space = 4;
csv_name = sprintf('../S_parameters_sim/width/W%d/L%dW%dS%d.csv',width,len,width,space);

%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 100e9;
freq_min = 0.5e9;
num_pi = ceil(len/12.5-1e-6);
len = len *1e-6;
% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[ s_params,freq_sim] = hfss_csv_2_sparams(csv_name,zero_freq,freq_unit);
if max(freq_sim)< freq_max || min(freq_sim)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq_sim<=freq_max & freq_sim>=freq_min );
freq_sim = freq_sim(freq_sim<=freq_max & freq_sim>=freq_min );
[RLGC_sim,gamma_sim,Z_sim] = S_2_RLGC(s_params,freq_sim,len);


load('../tmp_data/cpwmodelw4-12.mat');
s_params_sim_i =cpwmodel(1).files_info(2).Sparam_i;
freq_sim_i = cpwmodel(1).files_info(2).freq;
RLGC_sim_i = cpwmodel(1).files_info(2).RLGC_i;
Z_sim_i = cpwmodel(1).files_info(2).Z_i;
gamma_sim_i = cpwmodel(1).files_info(2).gamma_i;



csv_name = sprintf('../S_parameters_measure/Measure_L200W4S4_gamma_l2l.csv');
freq_alpha_beta = csvread(csv_name,2,0);
freq_measure = freq_alpha_beta(:,1)*1e9;
gamma_measure = (complex(freq_alpha_beta(:,2)*100,freq_alpha_beta(:,3)*100));   


%% plot gamma



figure
hold on
plot(freq_sim,real(gamma_sim),'-r*');
plot(freq_sim_i,real(gamma_sim_i),'-gs');
plot(freq_measure,real(gamma_measure),'-bo');
legend('em-sim','em-sim-intrinsic','measure');
xlabel('freq');
title('alpha');
grid on
grid minor
hold off

figure
hold on
plot(freq_sim,imag(gamma_sim),'-r*');
plot(freq_sim_i,imag(gamma_sim_i),'-gs');
plot(freq_measure,imag(gamma_measure),'-bo');
legend('em-sim','em-sim-intrinsic','measure');
xlabel('freq');
title('beta');
grid on
grid minor
hold off

% close all
% write xls

% xlswrite('./tmp_data/gamma_sim_intrinsic_l2l.xlsx',[freq_sim,real(gamma_sim),real(gamma_sim_i),...
%                                                         real(gamma_measure),...
%                                                         imag(gamma_sim),imag(gamma_sim_i),...
%                                                         imag(gamma_measure)])

