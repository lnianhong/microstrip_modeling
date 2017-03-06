clc;clear;close all
dbstop if error;
addpath('./function')
% TSMC65nm_msline;
% s_params = permute(S,[2 3 1]);
% freq = f';
% len =100e-6;

% l2w4s4_file = './S_parameters_sim/S400_ideal_500G_VeryLarge.csv';
% l2w4s4_file = './S_parameters_sim/PEC.csv';   
% l2w4s4_file = './S_parameters_sim/Transission.csv';
% l2w4s4_file = './S_parameters_sim/lump_port_ideal_400u.csv';
l2w4s4_file = './S_parameters_sim/waveport_400u_ideal.csv';

% % csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max =995e9;
freq_min = 1e9;
% len =str2double(cell2mat(regexp(l2w4s4_file,'\d{2,3}', 'match')));
len = 400;
num_pi = ceil(len/12.5);
len = len *1e-6;
% % the unit is different with doctor Fu��doctor Fu use cm as the unit of the length
[ s_params,freq] = hfss_csv_2_sparams(l2w4s4_file,zero_freq,freq_unit);
freq = freq*1000;
if max(freq)< freq_max || min(freq)>freq_min
    error('max(freq)< freq_max || min(freq)>freq_min');
end
s_params = s_params(:,:,freq<=freq_max & freq>=freq_min );
freq = freq(freq<=freq_max & freq>=freq_min );

%% extract the RLGC  
[R,L,G,C,gamma,Z0] = S_2_RLGC(s_params,freq,len); % the unit length is meter!
figure
plot(freq,R*0.01);
% R(740:1000) =R(740); 
L_omega = 2*pi.*freq.*L;
C_omega = 2*pi.*freq.*C;

Z_equal = R+1i.*L_omega+1./(G+1i.*C_omega);


deta_len =1e-8;
num_deta = len/deta_len;

R_deta = R*deta_len;
L_deta = L*deta_len;
G_deta = G*deta_len;
C_deta = C*deta_len;
L_deta_omega = 1i*2*pi.*freq.*L_deta;
C_deta_omega = 1i*2*pi.*freq.*C_deta;

ABCD= zeros(2,2,length(freq));
for k =1:length(freq)
    ABCD(:,:,k) = ([1,R_deta(k)+L_deta_omega(k);0,1]*[1,0;C_deta_omega(k)+G_deta(k),1])^num_deta;
end

Y_param = abcd2y(ABCD);
Y11 = reshape(Y_param(1,1,:),length(freq),[]);
R_equal =real(1./Y11);
L_equal =imag(1./Y11)./(2*pi*freq);

Y_param_o = s2y(s_params);
Y11_o = reshape(Y_param_o(1,1,:),length(freq),[]);
R_equal_o =real(1./Y11_o);
L_equal_o =imag(1./Y11_o)./(2*pi*freq);
% R_parallel =

% figure
% plot(freq,R,freq,R_equal);
% legend('R','R_equal')
% grid on
% grid minor


figure
[ax,p1,p2]=plotyy(freq,R_equal_o,freq,R_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'R') % label left y-axis
ylabel(ax(2),'R_equal') % label right y-axis
grid(ax(1),'minor')
hold off

figure
[ax,p1,p2]=plotyy(freq,L_equal_o,freq,L_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'L') % label left y-axis
ylabel(ax(2),'L_equal') % label right y-axis
grid(ax(1),'minor')
hold off







