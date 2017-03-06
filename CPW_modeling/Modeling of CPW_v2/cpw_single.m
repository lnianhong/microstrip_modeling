function [ output_args ] = cpw_single( file_name,len,freq_min_max,f_123_mat,lambda,num_pi,disp_sw )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = max(freq_min_max);
freq_min = min(freq_min_max);
% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[ s_params,freq] = hfss_csv_2_sparams(file_name,zero_freq,freq_unit);
if max(freq)< freq_max || min(freq)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
freq = freq(freq<=freq_max & freq>=freq_min );
%% extract the RLGC

[R,L,G,C,gamma] = S_2_RLGC(s_params,freq,len); % the unit length is meter!
%% model RL
lambda_RL = lambda(:,1);
weight_RL = ones(length(freq),2)./length(freq);
[R_fit,L_fit,R_0123_fit,L_0123_fit,f_fit_RL,Err_RL,Err_min_RL] =...,
    fit_RLGC(f_123_mat,freq,R,L,G,C,lambda_RL,weight_RL,'RL',3);
%% model GC
lambda_GC = lambda(:,2);
weight_GC = ones(length(freq),2)./length(freq);
[G_fit,C_fit,G_0123_fit,C_0123_fit,f_fit_GC,Err_GC,Err_min_GC] = ...,
    fit_RLGC(f_123_mat,freq,R,L,G,C,lambda_GC,weight_GC,'GC',3);

%% RLGC display
RLGC = [R,L,G,C];
if strcmp(disp_sw,'on')
    RLGC_fit = [R_fit,L_fit,G_fit,C_fit];
    plot_RLGC_double(freq,RLGC,RLGC_fit,{'sim','fit'},'RLGC: sim vs fit',{'-r','--b'});
    disp_RLGC_err( RLGC,RLGC_fit,f_fit_RL,f_fit_GC,'Summary of RLGC fit');
end
%% use equations to calculate the s parameters of the equivalent model

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

end

