% 理想的的传输线谐振现象---周期性
clc;clear;close all
dbstop if error;
addpath('../function')
% TSMC65nm_msline;
% s_params = permute(S,[2 3 1]);
% freq = f';
% len =100e-6;

% l2w4s4_file = './S_parameters_sim/S400_ideal_500G_VeryLarge.csv';
% l2w4s4_file = './S_parameters_sim/PEC.csv';
l2w4s4_file = '../S_parameters_sim/special/Transission.csv';
% % csvwrite writes a maximum of five significant digits. If you need greater precision, use dlmwrite with a precision argument.
freq_unit = 'GHz';
zero_freq = 0;% dont't deal 0GHz
freq_max =1500e9;
freq_min = 0.5e9;
% len =str2double(cell2mat(regexp(l2w4s4_file,'\d{2,3}', 'match')));
len = 400;
num_pi = ceil(len/12.5);
len = len *1e-6;
% % the unit is different with doctor Fu，doctor Fu use cm as the unit of the length
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
% R_parallel =

% figure
% plot(freq,R,freq,R_equal);
% legend('R','R_equal')
% grid on
% grid minor


figure
[ax,p1,p2]=plotyy(freq,R,freq,R_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'R') % label left y-axis
ylabel(ax(2),'R_equal') % label right y-axis
grid(ax(1),'minor')
hold off

figure
[ax,p1,p2]=plotyy(freq,L,freq,L_equal);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'L') % label left y-axis
ylabel(ax(2),'L_equal') % label right y-axis
grid(ax(1),'minor')
hold off


alpha = real(gamma);
beta = imag(gamma);
beta_len = beta*len;

alpha_Z = alpha.*real(Z0);
beta_X = beta.*imag(Z0);

figure
[ax,p1,p2]=plotyy(freq,R,freq,beta_len);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'R') % label left y-axis
ylabel(ax(2),'beta * len') % label right y-axis
grid(ax(1),'minor')
hold off



figure 
plot(freq,alpha_Z,freq,beta_X,freq,alpha_Z-beta_X);
xlabel('freq') % label x-axis
ylabel('R') % label left y-axis
legend('alpha\_Z','beta\_X','R')
grid minor

figure 
plot(freq,alpha_Z,freq,beta_X);
xlabel('freq') % label x-axis
ylabel('R') % label left y-axis
legend('alpha\_Z','beta\_X')
grid minor

figure 
plot(freq,real(Z0),freq,imag(Z0));
xlabel('freq') % label x-axis
ylabel('Z') % label left y-axis
legend('real(Z)','imag(Z)')
grid minor

figure
[ax,p1,p2]=plotyy(freq,alpha,freq,beta_len);
xlabel(ax(1),'freq') % label x-axis
ylabel(ax(1),'alpha') % label left y-axis
ylabel(ax(2),'beta * len') % label right y-axis
grid(ax(1),'minor')
hold off
