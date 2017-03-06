function [ Err ] = disp_RLGC_err( RLGC,RLGC_fit,f_fit_RL,f_fit_GC,name_str)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R = RLGC(:,1);
L = RLGC(:,2);
G = RLGC(:,3);
C = RLGC(:,4);
R_fit = RLGC_fit(:,1);
L_fit = RLGC_fit(:,2);
G_fit = RLGC_fit(:,3);
C_fit = RLGC_fit(:,4);



Err_R_max = max(abs(1-R_fit./R));
Err_R_ave = mean(abs(1-R_fit./R));
Err_L_max = max(abs(1-L_fit./L));
Err_L_ave = mean(abs(1-L_fit./L));
Err_G_max = max(abs(1-G_fit./G));
Err_G_ave = mean(abs(1-G_fit./G));
Err_C_max = max(abs(1-C_fit./C));
Err_C_ave = mean(abs(1-C_fit./C));

Err = [Err_R_max;Err_R_ave;Err_L_max;Err_L_ave;...,
       Err_G_max;Err_G_ave;Err_C_max;Err_C_ave];
disp('    ')
fprintf('=================================================================================\n')
fprintf('                            %s                                  \n',name_str);
fprintf('=================================================================================\n')

fprintf('The corner frequencies of the RL network:f1=%.2f GHz\t f2=%.2f GHz\t f3=%.2f GHz\n '..., 
                                    ,f_fit_RL(1)*1e-9,f_fit_RL(2)*1e-9,f_fit_RL(3)*1e-9);
fprintf('The corner frequencies of the RL network:f1=%.2f GHz\t f2=%.2f GHz\t f3=%.2f GHz\n '..., 
                                    ,f_fit_GC(1)*1e-9,f_fit_GC(2)*1e-9,f_fit_GC(3)*1e-9);
fprintf(' Maxium error ratio of R :%.2f%% \n',Err_R_max.*100);
fprintf(' Average error ratio of R:%.2f%% \n',Err_R_ave.*100);
fprintf(' Maxium error ratio of L :%.2f%% \n',Err_L_max.*100);
fprintf(' Average error ratio of L:%.2f%% \n',Err_L_ave.*100);
fprintf(' Maxium error ratio of G :%.2f%% \n',Err_G_max.*100);
fprintf(' Average error ratio of G:%.2f%% \n',Err_G_ave.*100);
fprintf(' Maxium error ratio of C :%.2f%% \n',Err_C_max.*100);
fprintf(' Average error ratio of C:%.2f%% \n',Err_C_ave.*100);
fprintf('=================================================================================\n\n')


end

