function [Err ] = disp_alpha_beta_err_v2( gamma,gamma_model,name_str)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
alpha = real(gamma);
beta = imag(gamma);
alpha_model = real(gamma_model);
beta_model = imag(gamma_model);

Err_alpha = abs(1-alpha./alpha_model);
Err_beta = abs(1-beta./beta_model);

Err_alpha_max = max(Err_alpha);
Err_alpha_ave = mean(Err_alpha);
Err_beta_max = max(Err_beta);
Err_beta_ave = mean(Err_beta);

Err = [Err_alpha_max;Err_alpha_ave;...,
       Err_beta_max;Err_beta_ave];

disp('    ')
fprintf('=================================================================================\n')
fprintf('                            %s                                  \n',name_str);
fprintf('=================================================================================\n')

fprintf(' Maxium error ratio of alpha :%.2f%% \n',Err_alpha_max .*100);
fprintf(' Average error ratio of alpha:%.2f%% \n',Err_alpha_ave.*100);
fprintf(' Maxium error ratio of beta :%.2f%% \n',Err_beta_max .*100);
fprintf(' Average error ratio of beta:%.2f%% \n',Err_beta_ave.*100);


fprintf('=================================================================================\n\n')
end

