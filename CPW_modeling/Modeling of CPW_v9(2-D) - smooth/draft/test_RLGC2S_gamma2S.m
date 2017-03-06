clc;clear;close all

dbstop if error;
l2w4s4_file = './S_parameters_sim/length/L150_S.csv';

freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 100e9;
freq_min = 0.5e9;
len =str2double(cell2mat(regexp(l2w4s4_file,'\d{2,3}', 'match')));
% len = 100;
num_pi = ceil(len/50);
len = len *1e-6;
% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[ s_params,freq] = hfss_csv_2_sparams(l2w4s4_file,zero_freq,freq_unit);
if max(freq)< freq_max || min(freq)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
freq = freq(freq<=freq_max & freq>=freq_min );
%% extract the RLGC

[RLGC,gamma,Z0] = S_2_RLGC(s_params,freq,len); % the unit length is meter!

%% test RLGC2s
tic
RLGC_S = RLGC_2_S( RLGC,freq,len);
toc
tic
gammaZ_S = Z_gamma_2_S( Z0,gamma,freq,len);
toc
plot_Sparam_double(freq,s_params,RLGC_S,{'S_sim','RLGC_S'},'Test RLGC_S');
plot_Sparam_double(freq,s_params,gammaZ_S,{'S_sim','gammaZ_S'},'Test gammaZ_S');