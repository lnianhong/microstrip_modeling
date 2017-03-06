function [ Err ] = disp_Sparam_error( s_params1,s_params2,name_str)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
S11_1_R = real(reshape(s_params1(1,1,:),[],1));
S12_1_R = real(reshape(s_params1(1,2,:),[],1));
% S21_1_R = real(reshape(s_params1(2,1,:),[],1));
% S22_1_R = real(reshape(s_params1(2,2,:),[],1));

S11_1_I = imag(reshape(s_params1(1,1,:),[],1));
S12_1_I = imag(reshape(s_params1(1,2,:),[],1));
% S21_1_I = imag(reshape(s_params1(2,1,:),[],1));
% S22_1_I = imag(reshape(s_params1(2,2,:),[],1));

S11_2_R = real(reshape(s_params2(1,1,:),[],1));
S12_2_R = real(reshape(s_params2(1,2,:),[],1));
% S21_2_R = real(reshape(s_params2(2,1,:),[],1));
% S22_2_R = real(reshape(s_params2(2,2,:),[],1));

S11_2_I = imag(reshape(s_params2(1,1,:),[],1));
S12_2_I = imag(reshape(s_params2(1,2,:),[],1));
% S21_2_I = imag(reshape(s_params2(2,1,:),[],1));
% S22_2_I = imag(reshape(s_params2(2,2,:),[],1));

Err_S11_R_max = max(abs(1-S11_2_R./S11_1_R));
Err_S11_R_ave = mean(abs(1-S11_2_R./S11_1_R));
Err_S12_R_max = max(abs(1-S12_2_R./S12_1_R));
Err_S12_R_ave = mean(abs(1-S12_2_R./S12_1_R));
Err_S11_I_max = max(abs(1-S11_2_I./S11_1_I));
Err_S11_I_ave = mean(abs(1-S11_2_I./S11_1_I));
Err_S12_I_max = max(abs(1-S12_2_I./S12_1_I));
Err_S12_I_ave = mean(abs(1-S12_2_I./S12_1_I));

Err = [Err_S11_R_max;Err_S11_R_ave;Err_S11_I_max;Err_S11_I_ave;...,
       Err_S12_R_max;Err_S12_R_ave;Err_S12_I_max;Err_S12_I_ave];

disp('    ')
fprintf('=================================================================================\n')
fprintf('                            %s                                  \n',name_str);
fprintf('=================================================================================\n')

fprintf(' Maxium error ratio of Real(S11) :%.2f%% \n',Err_S11_R_max .*100);
fprintf(' Average error ratio of Real(S11):%.2f%% \n',Err_S11_R_ave.*100);
fprintf(' Maxium error ratio of Imag(S11) :%.2f%% \n',Err_S11_I_max .*100);
fprintf(' Average error ratio of Imag(S11):%.2f%% \n',Err_S11_I_ave.*100);

fprintf(' Maxium error ratio of Real(S12) :%.2f%% \n',Err_S12_R_max .*100);
fprintf(' Average error ratio of Real(S12):%.2f%% \n',Err_S12_R_ave.*100);
fprintf(' Maxium error ratio of Imag(S12) :%.2f%% \n',Err_S12_I_max .*100);
fprintf(' Average error ratio of Imag(S12):%.2f%% \n',Err_S12_I_ave.*100);

fprintf('=================================================================================\n\n')


end

