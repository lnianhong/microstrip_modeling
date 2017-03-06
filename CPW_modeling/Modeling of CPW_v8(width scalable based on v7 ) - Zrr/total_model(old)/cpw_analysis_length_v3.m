% 不考虑端口效应，长度分析，有非常详细的图
clc;clear;close all
dbstop if error;
addpath('../function')
folder_path = '../S_parameters_sim/length/';
files_name = dir('../S_parameters_sim/length/L*_S.csv');
files_num = length(files_name);
R_0123 = zeros(4,files_num);
L_0123 = zeros(4,files_num);
G_0123 = zeros(4,files_num);
C_0123 = zeros(4,files_num);


f_max =100;
freq_min_max = [0.5,f_max]*1e9;

R_sim = zeros(2*f_max,files_num);
L_sim = zeros(2*f_max,files_num);
G_sim = zeros(2*f_max,files_num);
C_sim = zeros(2*f_max,files_num);
alpha_sim = zeros(2*f_max,files_num);
beta_sim = zeros(2*f_max,files_num);
alpha_model = zeros(2*f_max,files_num);
beta_model = zeros(2*f_max,files_num);

Err_RLGC_model = zeros(8,files_num);
Err_alpha_beta = zeros(4,files_num);

len = zeros(1,files_num);


f_2_zone = (2:0.5:28)*1e9;
% f_2_zone = (8:10:18)*1e9;
% f_2_zone = 10*1e9;
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
    [ RLGC_0123_fit,RLGC,RLGC_model,gamma,gamma_model,f_fit_RL,f_fit_GC,Err_RLGC_fit,Err_RLGC_model(:,k),Err_s,Err_alpha_beta(:,k)] ...,
        = cpw_single_v2( file_name,len(k),freq_min_max,f_123_mat,lambda,num_pi,disp_sw );
    R_0123(:,k) = RLGC_0123_fit(:,1);
    L_0123(:,k) = RLGC_0123_fit(:,2);
    G_0123(:,k) = RLGC_0123_fit(:,3);
    C_0123(:,k) = RLGC_0123_fit(:,4);
    f_fit(1,k) = f_fit_RL(2);
    f_fit(2,k) = f_fit_GC(2);
    
    R_sim(:,k) = RLGC(:,1);
    L_sim(:,k) = RLGC(:,2);
    G_sim(:,k) = RLGC(:,3);
    C_sim(:,k) = RLGC(:,4);
    
    alpha_sim(:,k) = real(gamma);
    beta_sim(:,k) = imag(gamma);
    alpha_model(:,k) = real(gamma_model);
    beta_model = imag(gamma_model);
    
    
end
 len = len*1e6;
%% RLGC 0123 SUBPLOT 4 & ERROR
plot_4_single(len,R_0123,{'R0','R1','R2','R3'},'Length [\mum]','Resistance [\Omega/m]','R0123','-*r');
plot_4_single(len,L_0123,{'L0','L1','L2','L3'},'Length [\mum]','Inductance [H/m]','L0123','-*r');
plot_4_single(len,G_0123,{'G0','G1','G2','G3'},'Length [\mum]','Conductance [S/m]','G0123','-*r');
plot_4_single(len,C_0123,{'C0','C1','C2','C3'},'Length [\mum]','Capacitance [F/m]','C0123','-*r');
plotyy_4(len,Err_RLGC_model*100,{'R','L','G','C'},'Length [\mum]',{'ave err(%)','max err(%)'},'Err of RLGC');
plotyy_2(len,Err_alpha_beta*100,{'\alpha','\beta'},'Length [\mum]',{'ave err(%)','max err(%)'},'Err of alpha & beta');
% 
% 
 freq = 0.5:0.5:f_max;
%% RLGC VS FREQUENCY under different length
 figure
plot(freq,R_sim);
title('R');
xlabel('Frequency');
ylabel('Resistance [\Omega/m]');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor

figure
plot(freq,L_sim);
title('L');
xlabel('Frequency');
ylabel('Inductance [H/m]');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor

figure
plot(freq,G_sim);
title('G');
xlabel('Frequency');
ylabel('Conductance [S/m]');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor

figure
plot(freq,C_sim);
title('C');
xlabel('Frequency');
ylabel('Capacitance [F/m]');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor


figure
plot(freq,alpha_sim);
title('alpha');
xlabel('Frequency');
ylabel('alpha');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor

figure
plot(freq,beta_sim);
title('beta');
xlabel('Frequency');
ylabel('beta');
legend('L=150','L=200','L=233','L=250','L=300','L=350','L=400','L=450','L=500','L=550','L=600');
grid on
grid minor


%
 index = [10,50,100]*2;
% alpha beta 
for k =1:3
    figure
    plot(len,alpha_sim(index(k),:));
    title(['alpha freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('alpha');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end
for k =1:3
    figure
    plot(len,beta_sim(index(k),:));
    title(['beta freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('beta');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end
% RLGC unit length
for k =1:3
    figure
    plot(len,R_sim(index(k),:));
    title(['R freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('Resistance [\Omega/m]');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end

for k =1:3
    figure
    plot(len,L_sim(index(k),:));
    title(['L freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('Inductance [H/m]');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end

for k =1:3
    figure
    plot(len,G_sim(index(k),:));
    title(['G freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('Conductance [S/m]');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end

for k =1:3
    figure
    plot(len,C_sim(index(k),:));
    title(['C freq=',num2str(index(k)/2),'GHz']);
    xlabel('length');
    ylabel('Capacitance [F/m]');
    legend(['freq=',num2str(index(k)/2),'GHz']);
    grid on
    grid minor
end
% alpha beta VS length under different frequency
figure
plot(len,beta_sim(index,:));
title('beta');
xlabel('length');
ylabel('beta');
legend('freq=10GHz','freq=50GHz','freq=100GHz');
grid on
grid minor

% R0123 in one figure
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

% the fit frequency
figure
plot(len,f_fit(1,:)./1e9,'-*r',len,f_fit(2,:)./1e9,'-ob')
legend('Freq\_RL','Freq\_GC')
grid on
grid minor
figure
plot(len,R_sim(20:20:200,:));
title('R');
xlabel('length');
ylabel('Resistance [\Omega/m]');
legend('f=10','f=20','f=30','f=40','f=50','f=60','f=70','f=80','f=90','f=100');
grid on
grid minor
figure
plot(len,L_sim(20:20:200,:));
title('L');
xlabel('length');
ylabel('Inductance [H/m]');
legend('f=10','f=20','f=30','f=40','f=50','f=60','f=70','f=80','f=90','f=100');
grid on
grid minor
figure
plot(len,G_sim(20:20:200,:));
title('G');
xlabel('length');
ylabel('Conductance [S/m]');
legend('f=10','f=20','f=30','f=40','f=50','f=60','f=70','f=80','f=90','f=100');
grid on
grid minor

figure
plot(len,C_sim(20:20:200,:));
title('C');
xlabel('length');
ylabel('Capacitance [F/m]');
legend('f=10','f=20','f=30','f=40','f=50','f=60','f=70','f=80','f=90','f=100');
grid on
grid minor

