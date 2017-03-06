clc;clear;close all
dbstop if error;
% l2w4s4_file = './S_parameters_sim/L2W4S4_150G.csv';
l2w4s4_file = './S_parameters_sim/L2W4S5.csv';
% l2w4s4_file = './S_parameters_sim/L400_S.csv';
%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 100e9;
[ s_params,freq] = hfss_csv_2_sparams(l2w4s4_file,zero_freq,freq_unit);
s_params = s_params(:,:,freq<=freq_max);
freq = freq(freq<=freq_max);
%% extract the RLGC
len =200e-6;% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[R,L,G,C,gamma,Z0] = S_2_RLGC(s_params,freq,len); % the unit length is meter!

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
plot_RLGC_double(freq,RLGC,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
disp_RLGC_err( RLGC,RLGC_fit,f_fit_RL,f_fit_GC,'Summary of RLGC fit');

%% use equations to calculate the s parameters of the equivalent model
num_pi = 32;
[ S_model_cal] = cpw_model_pi_net(freq,R_0123_fit,L_0123_fit,G_0123_fit,C_0123_fit,f_fit_RL,f_fit_GC,len,num_pi);

[R_model,L_model,G_model,C_model,gamma_model] = S_2_RLGC(S_model_cal,freq,len); % the unit length is meter!

RLGC_model = [R_model,L_model,G_model,C_model];
plot_RLGC_double(freq,RLGC,RLGC_model,{'sim','model'},'RLGC: sim vs model',{'-r','--b'});
disp_RLGC_err( RLGC,RLGC_model,f_fit_RL,f_fit_GC,'Summary of RLGC model');
plot_Sparam_double(freq,s_params,S_model_cal,{'hfss-sim','model'},'S parameters dB (em sim VS model)');
plot_Sparam_double_Real_Imag(freq,s_params,S_model_cal,{'hfss-sim','model'},'S parameters(em sim VS model)','off' );
disp_Sparam_error( s_params,S_model_cal,'Error of S parameters');
[Err_alpha,Err_beta ]=plot_gamma_double(freq,gamma,gamma_model,{'sim','model'},'alpha and beta: sim vs model',{'-r','--b'} );
disp_alpha_beta_err( Err_alpha,Err_beta,'Error of alpha & beta' );


% %% draw the S paramaters
% % s parameters of modeling ,use ads to simulate the schematic
% l2w4s4_file_model = './S_parameters_model/L2W4S4_model.csv';
% data_f_s = csvread(l2w4s4_file_model,0,1);
% S_model_ads = zeros(2,2,length(freq));
% S_model_ads(1,1,:) = (complex(data_f_s(:,1),data_f_s(:,2))+complex(data_f_s(:,7),data_f_s(:,8)))./2;
% S_model_ads(1,2,:) = (complex(data_f_s(:,3),data_f_s(:,4))+complex(data_f_s(:,5),data_f_s(:,6)))./2;
% S_model_ads(2,1,:) = S_model_ads(1,2,:);
% S_model_ads(2,2,:) = S_model_ads(1,1,:);
% %% ads vs sim
% [R_ads,L_ads,G_ads,C_ads,gamma_ads] = S_2_RLGC(S_model_ads,freq,len); % the unit length is meter!
% RLGC_ads = [R_ads,L_ads,G_ads,C_ads];
% plot_RLGC_double(freq,RLGC,RLGC_ads,{'sim','model'},'RLGC: sim vs model-ads',{'-r','--b'});
% disp_RLGC_err( RLGC,RLGC_ads,f_fit_RL,f_fit_GC,'Summary of RLGC model');
% plot_Sparam_double(freq,s_params,S_model_ads,{'hfss-sim','model-ads'},'S parameters(em sim VS ads model)');
% plot_gamma_double(freq,gamma,gamma_ads,{'sim','model-ads'},'alpha and beta: sim vs ads model',{'-r','--b'} );
% 
% %% ads vs cal
% plot_RLGC_double(freq,RLGC_model,RLGC_ads,{'model','model-ads'},'RLGC: model vs model-ads',{'-r','--b'});
% disp_RLGC_err( RLGC_model,RLGC_ads,f_fit_RL,f_fit_GC,'Summary of RLGC model');
% plot_Sparam_double(freq,S_model_cal,S_model_ads,{'hfss-sim','model-ads'},'S parameters( cal VS ads model)');
% plot_gamma_double(freq,gamma_model,gamma_ads,{'cal','model-ads'},'alpha and beta: cal vs ads model',{'-r','--b'} );


% L_0123_200u = L_0123_fit*len*1e9 ;% nH
% R_0123_200u = R_0123_fit*len;% omega
% G_0123_200u  = G_0123_fit*len; % s
% Rg_0123_200u = 1./G_0123_200u ; %omega
% C_0123_200u = C_0123_fit*len*1e12; %pF



