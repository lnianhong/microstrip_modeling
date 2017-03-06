function [ file_info ] = model_total_baseinfo( file_info )
% model a single model(total)

freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max = 100e9;
freq_min = 0.5e9;

% the unit is different with doctor Fu£¬doctor Fu use cm as the unit of the length
[ s_params,freq] = hfss_csv_2_sparams(file_info.name,zero_freq,freq_unit);
if max(freq)< freq_max || min(freq)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
freq = freq(freq<=freq_max & freq>=freq_min );
%% extract the RLGC and RLGC 0123
[RLGC_sim,gamma_sim,Z_sim] = S_2_RLGC(s_params,freq,file_info.length);
% [ ~,RLGC_0123_fit,f_fit ] = RLGC_2_0123( RLGC_sim,freq);
% 
% [ S_model_cal] = cpw_model_pi_net(freq,RLGC_0123_fit,file_info.length,file_info.num_pi);
% [RLGC_fit,gamma_fit,Z_fit] = S_2_RLGC(S_model_cal,freq,file_info.length); % the unit length is meter!

file_info.S = s_params;
% file_info.S_fit = S_model_cal;
% file_info.RLGC_0123 = RLGC_0123_fit;
file_info.freq = freq;
file_info.RLGC_sim = RLGC_sim;
% file_info.RLGC_fit = RLGC_fit;
file_info.gamma_sim = gamma_sim;
% file_info.gamma_fit = gamma_fit;
file_info.Z_sim = Z_sim;
% file_info.Z_fit = Z_fit;
% file_info.f_fit = f_fit;

end

