clc;clear;close all
dbstop if error;
folder_path = './S_parameters_sim/space/';
cpw_space = 4:1:10;
files_num = length(cpw_space);
R_0123 = zeros(4,files_num);
L_0123 = zeros(4,files_num);
G_0123 = zeros(4,files_num);
C_0123 = zeros(4,files_num);

f_fit = zeros(2,files_num);
Err_RLGC_model = zeros(8,files_num);
Err_alpha_beta = zeros(4,files_num);

len = 200;
num_pi = ceil(len/12.5);
len = len*1e-6;
%  regexp(files_name(5).name,'W\d{1,2}', 'match')
freq_min_max = [0.5,100]*1e9;
f_2_zone = (5:0.5:25)*1e9;
f_1 = 1e9*ones(1,length(f_2_zone));%GHz
f_3 = 100e9*ones(1,length(f_2_zone));
f_123_mat = [f_1;f_2_zone;f_3];
lambda = ones(2,2)*0.5;
for k = 1:files_num
    file_name = [folder_path,'L2W4S',num2str(cpw_space(k)),'.csv'];
    
    disp_sw = 'off';
    [ RLGC_0123_fit,f_fit_RL,f_fit_GC,Err_RLGC_fit,Err_RLGC_model(:,k),Err_s,Err_alpha_beta(:,k)] ...,
        = cpw_single( file_name,len,freq_min_max,f_123_mat,lambda,num_pi,disp_sw );
    R_0123(:,k) = RLGC_0123_fit(:,1);
    L_0123(:,k) = RLGC_0123_fit(:,2);
    G_0123(:,k) = RLGC_0123_fit(:,3);
    C_0123(:,k) = RLGC_0123_fit(:,4);
    f_fit(1,k) = f_fit_RL(2);
    f_fit(2,k) = f_fit_GC(2);
end


plot_4_single(cpw_space,R_0123,{'R0','R1','R2','R3'},'Space [\mum]','Resistance [\Omega/m]','R0123','-*r');
plot_4_single(cpw_space,L_0123,{'L0','L1','L2','L3'},'Space [\mum]','Inductance [H/m]','L0123','-*r');
plot_4_single(cpw_space,G_0123,{'G0','G1','G2','G3'},'Space [\mum]','Conductance [S/m]','G0123','-*r');
plot_4_single(cpw_space,C_0123,{'C0','C1','C2','C3'},'Space [\mum]','Capacitance [F/m]','C0123','-*r');
plotyy_4(cpw_space,Err_RLGC_model*100,{'R','L','G','C'},'Space [\mum]',{'ave err(%)','max err(%)'},'Err of RLGC');
plotyy_2(cpw_space,Err_alpha_beta*100,{'\alpha','\beta'},'Space [\mum]',{'ave err(%)','max err(%)'},'Err of alpha & beta');

figure
plot(cpw_space,f_fit(1,:)./1e9,'-*r',cpw_space,f_fit(2,:)./1e9,'-ob')
legend('Freq\_RL','Freq\_GC')
grid on
grid minor

% figure
% plot(cpw_Space,R_0123)
% legend('R0','R1','R2','R3')
% grid on
% grid minor
% figure
% plot(cpw_Space,L_0123)
% legend('L0','L1','L2','L3')
% grid on
% grid minor
% figure
% plot(cpw_Space,G_0123)
% legend('G0','G1','G2','G3')
% grid on
% grid minor
% figure
% plot(cpw_Space,C_0123)
% legend('C0','C1','C2','C3')
% grid on
% grid minor

