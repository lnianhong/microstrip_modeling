clc;clear;close all
dbstop if error;
l2w4s4_file = './S_parameters_sim/L2W4S4.csv';
%csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
[ s_params,freq] = hfss_csv_2_sparams(l2w4s4_file,zero_freq,freq_unit);


%% extract the RLGC
len =200e-6;% the unit is different with doctor Fu��doctor Fu use cm as the unit of the length
[R,L,G,C] = S_2_RLGC(s_params,freq,len); % the unit length is meter!


%% model
f_2_zone = (5:0.5:20)*1e9;
lambda_R = 0.5;
lambda_L = 0.5;
lambda_G = 0.5;
lambda_C = 0.5;

weight_R = ones(1,length(freq))./length(freq);
weight_L = ones(1,length(freq))./length(freq);
weight_G = ones(1,length(freq))./length(freq);
weight_C = ones(1,length(freq))./length(freq);

Err_R = ones(length(f_2_zone),1);
Err_L = ones(length(f_2_zone),1);
Err_RL = ones(length(f_2_zone),1);

Err_G = ones(length(f_2_zone),1);
Err_C = ones(length(f_2_zone),1);
Err_GC = ones(length(f_2_zone),1);

Err_RL_min = 1;
Err_GC_min = 1;
f_1 = 1e9;%GHz
f_3 = 100e9;
%% model RL
for ii = 1:length(f_2_zone)
    
    f_2 = f_2_zone(ii);
    
    f_123 = [f_1;f_2;f_3];
    
    num_RL_net = 3;
    [L_0123,R_0123,~,~ ] = cpw_param_extract( f_123,freq,R,L,G,C,num_RL_net);
    % L_0123,R_0123,G_123,C_0123 are the prameters of each section!
    if sum(L_0123 <0) || sum(R_0123<0)
        continue
    end
    
    
    R_model = R_0123(1) + R_0123(2)* (1-1./(1+(freq./f_1).^2)) + ...,
        R_0123(3)* (1-1./(1+(freq./f_2).^2)) + ...,
        R_0123(4)* (1-1./(1+(freq./f_3).^2));
    
    L_model = L_0123(1) + L_0123(2)* (1./(1+(freq./f_1).^2)) + ...,
        L_0123(3)* (1./(1+(freq./f_2).^2)) + ...,
        L_0123(4)* (1./(1+(freq./f_3).^2));
    
    Err_R(ii) = weight_R*eval_model(R,R_model,'abs');% average error of R
    Err_L(ii) = weight_L*eval_model(L,L_model,'abs');% average error of L
    Err_RL(ii) = lambda_R*Err_R(ii) + lambda_L*Err_L(ii);
    
    if Err_RL(ii) < Err_RL_min
        Err_RL_min = Err_RL(ii);
        R_fit = R_model;
        L_fit = L_model;
        L_0123_fit = L_0123;
        R_0123_fit = R_0123;
        f2_RL_fit = f_2;
    end
    
end

%% MODEL GC
for ii = 1:length(f_2_zone)
    f_1 = 1e9;%GHz
    f_2 = f_2_zone(ii);
    f_3 = 100e9;
    f_123 = [f_1;f_2;f_3];
    
    num_RL_net = 3;
    [~,~,G_123,C_0123 ] = cpw_param_extract( f_123,freq,R,L,G,C,num_RL_net);
    % L_0123,R_0123,G_123,C_0123 are the prameters of each section!
    if sum(G_123 <0) || sum(C_0123<0)
        continue
    end
    
    G_model =             G_123(1)* (1-1./(1+(freq./f_1).^2)) + ...,
        G_123(2)* (1-1./(1+(freq./f_2).^2)) + ...,
        G_123(3)* (1-1./(1+(freq./f_3).^2));
    
    C_model = C_0123(1) + C_0123(2)* (1./(1+(freq./f_1).^2)) + ...,
        C_0123(3)* (1./(1+(freq./f_2).^2)) + ...,
        C_0123(4)* (1./(1+(freq./f_3).^2));
    
    Err_G(ii) = weight_G*eval_model(G,G_model,'abs');
    Err_C(ii) = weight_C*eval_model(C,C_model,'abs');
    Err_GC(ii) = lambda_G*Err_G(ii) + lambda_C*Err_C(ii);
    
    if Err_GC(ii) < Err_GC_min
        Err_GC_min = Err_GC(ii);
        G_fit = G_model;
        G_123_fit = G_123;
        C_fit = C_model;
        C_0123_fit = C_0123;
        f2_GC_fit = f_2;
    end
end





Err_R_max = max(abs(1-R_fit./R));
Err_R_ave = mean(abs(1-R_fit./R));
Err_L_max = max(abs(1-L_fit./L));
Err_L_ave = mean(abs(1-L_fit./L));

Err_G_max = max(abs(1-G_fit./G));
Err_G_ave = mean(abs(1-G_fit./G));
Err_G_max2 = max(abs(1-G_fit(2:end)./G(2:end)));

Err_C_max = max(abs(1-C_fit./C));
Err_C_ave = mean(abs(1-C_fit./C));
disp('    ')
disp('===========================================================================')
fprintf(' The second corner frequency of the RL network: f2_RL_fit=%.2f GHz\n ',f2_RL_fit.*1e-9);
fprintf('The second corner frequency of the GC network: f2_GC_fit=%.2f GHz \n',f2_GC_fit.*1e-9);
fprintf(' Maxium error ratio of R :%.2f%% \n',Err_R_max.*100);
fprintf(' Average error ratio of R:%.2f%% \n',Err_R_ave.*100);
fprintf(' Maxium error ratio of L :%.2f%% \n',Err_L_max.*100);
fprintf(' Average error ratio of L:%.2f%% \n',Err_L_ave.*100);
fprintf(' Maxium error ratio of G :%.2f%% \n',Err_G_max.*100);
fprintf(' Average error ratio of G:%.2f%% \n',Err_G_ave.*100);
fprintf(' Maxium error ratio of C :%.2f%% \n',Err_C_max.*100);
fprintf(' Average error ratio of C:%.2f%% \n',Err_C_ave.*100);

disp('===========================================================================')
if 1
    figure
    subplot(2,2,1)
    hold on
    plot(freq,R,'-r',freq,R_fit,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('R')
    % dim = [0.6 0.9 0.4 0.2 ];
    % str = {['Err_max:',num2str(Err_R_max*100,'%.2f'),'%'],'from 1 to 10'};
    % annotation('textbox',dim,'String',str,'FitBoxToText','on');
    hold off
    subplot(2,2,2)
    hold on
    plot(freq,L,'-r',freq,L_fit,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('L')
    hold off
    subplot(2,2,3)
    hold on
    plot(freq,G,'-r',freq,G_fit,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('G')
    hold off
    subplot(2,2,4)
    hold on
    plot(freq,C,'-r',freq,C_fit,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('C')
    hold off
    
end

L_0123_200u = L_0123_fit*len*1e9 ;% nH
R_0123_200u = R_0123_fit*len;% omega
G_123_200u  = G_123_fit*len; % s
Rg_123_200u = 1./G_123_200u ; %omega
C_0123_200u = C_0123_fit*len*1e12; %pF
%% draw the S paramaters
%% draw the S paramaters of simulation
S11_magdb = 20 *log10(abs(reshape(s_params(1,1,:),[],1)));
S12_magdb = 20 *log10(abs(reshape(s_params(1,2,:),[],1)));
S21_magdb = 20 *log10(abs(reshape(s_params(2,1,:),[],1)));
S22_magdb = 20 *log10(abs(reshape(s_params(2,2,:),[],1)));
%% s parameters of modeling ,use ads to simulate the schematic
l2w4s4_file_model = './S_parameters_model/L2W4S4_model.csv';
data_f_s = csvread(l2w4s4_file_model,0,1);
S11_model = (complex(data_f_s(:,1),data_f_s(:,2))+complex(data_f_s(:,7),data_f_s(:,8)))./2;
S12_model = (complex(data_f_s(:,3),data_f_s(:,4))+complex(data_f_s(:,5),data_f_s(:,6)))./2;
S21_model = S12_model;
S22_model = S11_model;

S11_model_magdb = 20 *log10(abs(S11_model));
S12_model_magdb = 20 *log10(abs(S12_model));
S21_model_magdb = S12_model_magdb;
S22_model_magdb = S11_model_magdb;


if 1
    figure
    hold on
    subplot(2,2,1)
    plot(freq,S11_magdb,'-r',freq,S11_model_magdb,'--b');
    legend('sim-hfss','model-ads');
    xlabel('freq/Hz');
    ylabel('S11/dB')
    hold off
    
    hold on
    subplot(2,2,2)
    plot(freq,S12_magdb,'-r',freq,S12_model_magdb,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S12/dB')
    hold off
    
    hold on
    subplot(2,2,3)
    plot(freq,S21_magdb,'-r',freq,S21_model_magdb,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S21/dB')
    hold off
    
    hold on
    subplot(2,2,4)
    plot(freq,S22_magdb,'-r',freq,S22_model_magdb,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S22/dB')
    hold off
end
%% use equations to calculate the s parameters of the equivalent model
num_pi = 4;
f_123_RL_fit = [f_1,f2_RL_fit,f_3];
f_123_GC_fit = [f_1,f2_GC_fit,f_3];
[ S_model_cal] = cpw_model_pi_net(freq,L_0123_fit,R_0123_fit,G_123_fit,C_0123_fit,f_123_RL_fit,f_123_GC_fit,len,num_pi);

S11_magdb_cal = 20 *log10(abs(reshape(S_model_cal(1,1,:),[],1)));
S12_magdb_cal = 20 *log10(abs(reshape(S_model_cal(1,2,:),[],1)));
S21_magdb_cal = 20 *log10(abs(reshape(S_model_cal(2,1,:),[],1)));
S22_magdb_cal = 20 *log10(abs(reshape(S_model_cal(2,2,:),[],1)));

err_cal_sim_s11 = mean(abs(1-(S11_magdb_cal./S11_model_magdb)))
err_cal_sim_s12 = mean(abs(1-(S12_magdb_cal./S12_model_magdb)))

if 1
    figure
    hold on
    subplot(2,2,1)
    plot(freq,S11_magdb,'-r',freq,S11_magdb_cal,'--b');
    legend('sim-hfss','model-cal');
    xlabel('freq/Hz');
    ylabel('S11/dB')
    hold off
    
    hold on
    subplot(2,2,2)
    plot(freq,S12_magdb,'-r',freq,S12_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S12/dB')
    hold off
    
    hold on
    subplot(2,2,3)
    plot(freq,S21_magdb,'-r',freq,S21_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S21/dB')
    hold off
    
    hold on
    subplot(2,2,4)
    plot(freq,S22_magdb,'-r',freq,S22_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S22/dB')
    hold off
end

if 1
    figure
    hold on
    subplot(2,2,1)
    plot(freq,S11_model_magdb,'-r',freq,S11_magdb_cal,'--b');
    legend('model-ads','model-cal');
    xlabel('freq/Hz');
    ylabel('S11/dB')
    hold off
    
    hold on
    subplot(2,2,2)
    plot(freq,S12_model_magdb,'-r',freq,S12_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S12/dB')
    hold off
    
    hold on
    subplot(2,2,3)
    plot(freq,S21_model_magdb,'-r',freq,S21_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S21/dB')
    hold off
    
    hold on
    subplot(2,2,4)
    plot(freq,S22_model_magdb,'-r',freq,S22_magdb_cal,'--b');
    legend('sim','model');
    xlabel('freq/Hz');
    ylabel('S22/dB')
    hold off
end


