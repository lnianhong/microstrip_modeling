clc;clear;close all
dbstop if error;
% l2w4s4_file = './S_parameters_sim/L2W4S4_150G.csv';
% l2w4s4_file = './S_parameters_sim/L2W4S5.csv';
l2w4s4_file = './S_parameters_sim/L350_S.csv';
%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 100e9;
freq_min = 0.5e9;
len =str2double(cell2mat(regexp(l2w4s4_file,'\d{2,3}', 'match')));
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

[R,L,G,C,gamma] = S_2_RLGC(s_params,freq,len); % the unit length is meter!

%% 
f_2_zone = (5:0.5:20)*1e9;
f_1 = 1e9*ones(1,length(f_2_zone));%GHz
f_3 = freq_max*ones(1,length(f_2_zone));
f_123_mat = [f_1;f_2_zone;f_3];
%% model RL
lambda_RL = [0.5;0.5];
weight_RL = ones(length(freq),2)./length(freq);
[R_fit,L_fit,R_0123_fit,L_0123_fit,f_fit_RL,Err_RL,Err_min_RL] =...,
              fit_RLGC(f_123_mat,freq,R,L,G,C,lambda_RL,weight_RL,'RL',3);
%% model GC
lambda_GC = [0.5;0.5];
weight_GC = ones(length(freq),2)./length(freq);
[G_fit,C_fit,G_0123_fit,C_0123_fit,f_fit_GC,Err_GC,Err_min_GC] = ...,
          fit_RLGC(f_123_mat,freq,R,L,G,C,lambda_GC,weight_GC,'GC',3);

%% RLGC display      
RLGC = [R,L,G,C];
RLGC_fit = [R_fit,L_fit,G_fit,C_fit];
% plot_RLGC_double(freq,RLGC,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
% disp_RLGC_err( RLGC,RLGC_fit,f_fit_RL,f_fit_GC,'Summary of RLGC fit');

%% use equations to calculate the s parameters of the equivalent model

[ S_model_cal] = cpw_model_pi_net(freq,R_0123_fit,L_0123_fit,G_0123_fit,C_0123_fit,f_fit_RL,f_fit_GC,len,num_pi);
[R_model,L_model,G_model,C_model,gamma_model] = S_2_RLGC(S_model_cal,freq,len); % the unit length is meter!
RLGC_model = [R_model,L_model,G_model,C_model];
plot_RLGC_double(freq,RLGC,RLGC_model,{'sim','model'},'RLGC: sim vs model',{'-r','--b'});
disp_RLGC_err( RLGC,RLGC_model,f_fit_RL,f_fit_GC,'Summary of RLGC model');
% plot_Sparam_double(freq,s_params,S_model_cal,{'hfss-sim','model'},'S parameters dB (em sim VS model)');
% plot_Sparam_double_Real_Imag(freq,s_params,S_model_cal,{'hfss-sim','model'},'S parameters(em sim VS model)','off' );
% disp_Sparam_error( s_params,S_model_cal,'Error of S parameters');
[Err_alpha,Err_beta ]=plot_gamma_double(freq,gamma,gamma_model,{'sim','model'},'alpha and beta: sim vs model',{'-r','--b'} );
disp_alpha_beta_err( Err_alpha,Err_beta,'Error of alpha & beta' );




