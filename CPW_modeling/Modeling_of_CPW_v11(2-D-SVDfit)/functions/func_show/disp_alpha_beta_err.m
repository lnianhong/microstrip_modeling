function [ Err ] =disp_alpha_beta_err( Err_alpha,Err_beta,name_str )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


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

