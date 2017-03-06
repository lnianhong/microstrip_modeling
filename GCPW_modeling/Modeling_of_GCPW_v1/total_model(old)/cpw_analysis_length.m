% 分析模板不同长度下的各个参数；不区分端口效应
clc;clear;close all
addpath('../function')
dbstop if error;
folder_path = '../S_parameters_sim/length/';
files_name = dir('../S_parameters_sim/length/L*_S.csv');
files_num = length(files_name);
R_0123 = zeros(4,files_num);
L_0123 = zeros(4,files_num);
G_0123 = zeros(4,files_num);
C_0123 = zeros(4,files_num);
f_fit = zeros(2,files_num);
Err_RLGC_model = zeros(8,files_num);
Err_alpha_beta = zeros(4,files_num);
 
len = zeros(1,files_num);

freq_min_max = [0.5,100]*1e9;
f_2_zone = (5:0.5:20)*1e9;
f_1 = 1e9*ones(1,length(f_2_zone));%GHz
f_3 = 100e9*ones(1,length(f_2_zone));
f_123_mat = [f_1;f_2_zone;f_3];
lambda = ones(2,2)*0.5;
for k = 1:files_num
    file_name = [folder_path,files_name(k).name];
    len(k) =str2double(cell2mat(regexp(file_name,'\d{3}', 'match')));
    if isnan(len(k))
        error('len(k) is nan!')
    end
    num_pi = ceil(len(k)/12.5);
    len(k) = len(k) *1e-6;
    disp_sw = 'off';
    [ RLGC_0123_fit,f_fit_RL,f_fit_GC,Err_RLGC_fit,Err_RLGC_model(:,k),Err_s,Err_alpha_beta(:,k)] ...,
        = cpw_single( file_name,len(k),freq_min_max,f_123_mat,lambda,num_pi,disp_sw );
    R_0123(:,k) = RLGC_0123_fit(:,1);
    L_0123(:,k) = RLGC_0123_fit(:,2);
    G_0123(:,k) = RLGC_0123_fit(:,3);
    C_0123(:,k) = RLGC_0123_fit(:,4);
    f_fit(1,k) = f_fit_RL(2);
    f_fit(2,k) = f_fit_GC(2);
    
end
len = len*1e6;
plot_4_single(len,R_0123,{'R0','R1','R2','R3'},'Length [\mum]','Resistance [\Omega/m]','R0123','-*r');
plot_4_single(len,L_0123,{'L0','L1','L2','L3'},'Length [\mum]','Inductance [H/m]','L0123','-*r');
plot_4_single(len,G_0123,{'G0','G1','G2','G3'},'Length [\mum]','Conductance [S/m]','G0123','-*r');
plot_4_single(len,C_0123,{'C0','C1','C2','C3'},'Length [\mum]','Capacitance [F/m]','C0123','-*r');
plotyy_4(len,Err_RLGC_model*100,{'R','L','G','C'},'Length [\mum]',{'ave err(%)','max err(%)'},'Err of RLGC');
plotyy_2(len,Err_alpha_beta*100,{'\alpha','\beta'},'Length [\mum]',{'ave err(%)','max err(%)'},'Err of alpha & beta');


% figure
% plot(len,R_0123)
% legend('R0','R1','R2','R3')
% figure
% plot(len,L_0123)
% legend('L0','L1','L2','L3')
% figure
% plot(len,G_0123)
% legend('G0','G1','G2','G3')
% figure
% plot(len,C_0123)
% legend('C0','C1','C2','C3')
% figure
% plot(len,f_fit./1e9,'-*r')
% legend('Freq\_RL','Freq\_GC')
% grid on
% grid minor

figure
plot(len,f_fit(1,:)./1e9,'-*r',len,f_fit(2,:)./1e9,'-ob')
legend('Freq\_RL','Freq\_GC')
grid on
grid minor

